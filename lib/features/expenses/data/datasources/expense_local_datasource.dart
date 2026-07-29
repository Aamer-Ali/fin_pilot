import 'package:fin_pilot/features/expenses/data/models/expense_model.dart';

abstract class ExpenseLocalDataSource {
  Future<void> addExpense(ExpenseModel expense);
}

/// In-memory placeholder until real local persistence (Hive) is wired up —
/// mirrors DashboardDummyDataSource until then.
class ExpenseDummyDataSource implements ExpenseLocalDataSource {
  final List<ExpenseModel> _expenses = [];

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _expenses.add(expense);
  }
}
