import 'package:fin_pilot/features/dashboard/data/models/category_spending_model.dart';
import 'package:fin_pilot/features/dashboard/data/models/dashboard_summary_model.dart';
import 'package:fin_pilot/features/dashboard/data/models/recent_activity_model.dart';
import 'package:fin_pilot/features/dashboard/data/models/trend_point_model.dart';
import 'package:fin_pilot/features/expenses/data/models/expense_hive_model.dart';
import 'package:hive_ce/hive.dart';

abstract class DashboardLocalDataSource {
  Future<DashboardSummaryModel> getDashboardSummary();
}

const _weekdayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

/// Rolls real spending data up from the same "expenses" Hive box the
/// expenses feature writes to (CLAUDE.md §3.2 — the local data source is
/// the only place allowed to touch Hive directly).
///
/// `totalBalance`, `outflowPercentage`, and `insightText` stay fixed
/// placeholders: they need an income/accounts concept and multi-month
/// history that don't exist yet, so computing them now would just be
/// different fake numbers.
class DashboardHiveDataSource implements DashboardLocalDataSource {
  DashboardHiveDataSource(this._expenseBox);

  final Box<ExpenseHiveModel> _expenseBox;

  @override
  Future<DashboardSummaryModel> getDashboardSummary() async {
    final expenses = _expenseBox.values.toList();
    final now = DateTime.now();

    final thisMonth = expenses
        .where((e) => e.date.year == now.year && e.date.month == now.month)
        .toList();
    final monthlySpending = thisMonth.fold<double>(
      0,
      (sum, e) => sum + e.amount,
    );

    return DashboardSummaryModel(
      totalBalance: 42950,
      monthlySpending: monthlySpending,
      outflowPercentage: 82,
      spendingMix: _spendingMix(thisMonth, monthlySpending),
      weeklyTrend: _weeklyTrend(expenses, now),
      insightText:
          'Spending data below is now real. Total Balance and Outflow % '
          'are still placeholders.',
      spendingChangePercent: 0,
      recentActivities: _recentActivities(expenses),
    );
  }

  List<CategorySpendingModel> _spendingMix(
    List<ExpenseHiveModel> monthExpenses,
    double monthlyTotal,
  ) {
    final totals = <String, double>{};
    for (final expense in monthExpenses) {
      totals[expense.category] =
          (totals[expense.category] ?? 0) + expense.amount;
    }
    final mix = totals.entries
        .map(
          (entry) => CategorySpendingModel(
            category: entry.key,
            amount: entry.value,
            percentage: monthlyTotal == 0
                ? 0
                : (entry.value / monthlyTotal) * 100,
          ),
        )
        .toList();
    mix.sort((a, b) => b.amount.compareTo(a.amount));
    return mix;
  }

  List<TrendPointModel> _weeklyTrend(
    List<ExpenseHiveModel> expenses,
    DateTime now,
  ) {
    final today = DateTime(now.year, now.month, now.day);
    return List.generate(7, (i) {
      final day = today.subtract(Duration(days: 6 - i));
      final total = expenses
          .where(
            (e) =>
                e.date.year == day.year &&
                e.date.month == day.month &&
                e.date.day == day.day,
          )
          .fold<double>(0, (sum, e) => sum + e.amount);
      return TrendPointModel(
        label: _weekdayLabels[day.weekday - 1],
        amount: total,
      );
    });
  }

  List<RecentActivityModel> _recentActivities(
    List<ExpenseHiveModel> expenses,
  ) {
    final sorted = [...expenses]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted
        .take(5)
        .map(
          (e) => RecentActivityModel(
            id: e.id,
            title: e.description.trim().isEmpty ? e.category : e.description,
            description: e.category,
            date: e.date,
            amount: e.amount,
            isIncome: false,
          ),
        )
        .toList();
  }
}
