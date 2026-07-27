import 'package:fin_pilot/features/dashboard/data/models/dashboard_summary_model.dart';

/// Local source of dashboard data. Backed by an in-memory dummy payload for
/// now — swap the body for a Hive read later without touching callers
/// (CLAUDE.md §3.2).
abstract class DashboardLocalDataSource {
  Future<DashboardSummaryModel> getDashboardSummary();
}

class DashboardDummyDataSource implements DashboardLocalDataSource {
  @override
  Future<DashboardSummaryModel> getDashboardSummary() async {
    return DashboardSummaryModel.fromJson(_dummyDashboardJson);
  }
}

final _dummyDashboardJson = {
  'totalBalance': 42950.0,
  'monthlySpending': 17370.0,
  'outflowPercentage': 82.0,
  'spendingMix': [
    {'category': 'Housing', 'amount': 7816.5, 'percentage': 45.0},
    {'category': 'Food', 'amount': 5211.0, 'percentage': 30.0},
    {'category': 'Transport', 'amount': 4342.5, 'percentage': 25.0},
  ],
  'weeklyTrend': [
    {'label': 'Mon', 'amount': 2400.0},
    {'label': 'Tue', 'amount': 1950.0},
    {'label': 'Wed', 'amount': 2650.0},
    {'label': 'Thu', 'amount': 1700.0},
    {'label': 'Fri', 'amount': 2100.0},
    {'label': 'Sat', 'amount': 1450.0},
    {'label': 'Sun', 'amount': 2820.0},
  ],
  'insightText':
      'Your discretionary spending is down by 12% compared to last month. '
      'Great job sticking to your goals.',
  'spendingChangePercent': -12.0,
  'recentActivities': [
    {
      'id': 'act-1',
      'title': 'Starbucks',
      'description': 'Coffee expense',
      'date': '2026-07-24T09:00:00.000',
      'amount': 650.0,
      'isIncome': false,
    },
    {
      'id': 'act-2',
      'title': 'Whole Foods',
      'description': 'Weekly groceries',
      'date': '2026-07-23T18:30:00.000',
      'amount': 14220.0,
      'isIncome': false,
    },
    {
      'id': 'act-3',
      'title': 'Public Transport',
      'description': 'Commute refill',
      'date': '2025-10-24T08:00:00.000',
      'amount': 2500.0,
      'isIncome': false,
    },
  ],
};