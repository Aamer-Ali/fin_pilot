import 'package:fin_pilot/features/dashboard/data/models/category_spending_model.dart';
import 'package:fin_pilot/features/dashboard/data/models/recent_activity_model.dart';
import 'package:fin_pilot/features/dashboard/data/models/trend_point_model.dart';
import 'package:fin_pilot/features/dashboard/domain/entities/dashboard_summary.dart';

class DashboardSummaryModel {
  const DashboardSummaryModel({
    required this.totalBalance,
    required this.monthlySpending,
    required this.outflowPercentage,
    required this.spendingMix,
    required this.weeklyTrend,
    required this.insightText,
    required this.spendingChangePercent,
    required this.recentActivities,
  });

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    return DashboardSummaryModel(
      totalBalance: (json['totalBalance'] as num).toDouble(),
      monthlySpending: (json['monthlySpending'] as num).toDouble(),
      outflowPercentage: (json['outflowPercentage'] as num).toDouble(),
      spendingMix: (json['spendingMix'] as List)
          .map((e) => CategorySpendingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      weeklyTrend: (json['weeklyTrend'] as List)
          .map((e) => TrendPointModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      insightText: json['insightText'] as String,
      spendingChangePercent: (json['spendingChangePercent'] as num).toDouble(),
      recentActivities: (json['recentActivities'] as List)
          .map((e) => RecentActivityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final double totalBalance;
  final double monthlySpending;
  final double outflowPercentage;
  final List<CategorySpendingModel> spendingMix;
  final List<TrendPointModel> weeklyTrend;
  final String insightText;
  final double spendingChangePercent;
  final List<RecentActivityModel> recentActivities;

  Map<String, dynamic> toJson() => {
    'totalBalance': totalBalance,
    'monthlySpending': monthlySpending,
    'outflowPercentage': outflowPercentage,
    'spendingMix': spendingMix.map((e) => e.toJson()).toList(),
    'weeklyTrend': weeklyTrend.map((e) => e.toJson()).toList(),
    'insightText': insightText,
    'spendingChangePercent': spendingChangePercent,
    'recentActivities': recentActivities.map((e) => e.toJson()).toList(),
  };

  DashboardSummary toEntity() => DashboardSummary(
    totalBalance: totalBalance,
    monthlySpending: monthlySpending,
    outflowPercentage: outflowPercentage,
    spendingMix: spendingMix.map((e) => e.toEntity()).toList(),
    weeklyTrend: weeklyTrend.map((e) => e.toEntity()).toList(),
    insightText: insightText,
    spendingChangePercent: spendingChangePercent,
    recentActivities: recentActivities.map((e) => e.toEntity()).toList(),
  );
}
