import 'package:equatable/equatable.dart';
import 'package:fin_pilot/features/dashboard/domain/entities/category_spending.dart';
import 'package:fin_pilot/features/dashboard/domain/entities/recent_activity.dart';
import 'package:fin_pilot/features/dashboard/domain/entities/trend_point.dart';

/// Aggregate root for everything the home screen needs in one read.
class   DashboardSummary extends Equatable {
  const DashboardSummary({
    required this.totalBalance,
    required this.monthlySpending,
    required this.outflowPercentage,
    required this.spendingMix,
    required this.weeklyTrend,
    required this.insightText,
    required this.spendingChangePercent,
    required this.recentActivities,
  });

  final double totalBalance;
  final double monthlySpending;

  /// Center-label stat for the Spending Mix donut, e.g. 82 for "82%".
  final double outflowPercentage;
  final List<CategorySpending> spendingMix;
  final List<TrendPoint> weeklyTrend;

  /// "Analytics Pulse" headline copy, e.g. spending-down callout.
  final String insightText;

  /// Signed change vs. previous period, e.g. -12 for a 12% decrease.
  final double spendingChangePercent;
  final List<RecentActivity> recentActivities;

  @override
  List<Object?> get props => [
    totalBalance,
    monthlySpending,
    outflowPercentage,
    spendingMix,
    weeklyTrend,
    insightText,
    spendingChangePercent,
    recentActivities,
  ];
}