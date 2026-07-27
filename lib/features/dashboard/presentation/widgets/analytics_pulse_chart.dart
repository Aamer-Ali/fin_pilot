import 'package:fin_pilot/core/theme/app_typography.dart';
import 'package:fin_pilot/features/dashboard/domain/entities/trend_point.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Bar rendering of [DashboardSummary.weeklyTrend]. Stateless and
/// data-only — the parent card owns the heading/insight copy, this just
/// draws the bars, so it only rebuilds when the trend values it was given
/// actually change.
class AnalyticsPulseChart extends StatelessWidget {
  const AnalyticsPulseChart({super.key, required this.weeklyTrend});

  final List<TrendPoint> weeklyTrend;

  static const double _barWidth = 20;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (weeklyTrend.isEmpty) {
      return Center(
        child: Text(
          "No trend data yet",
          style: AppTypography.bodySm.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    final highestIndex = _highestIndex();
    final maxAmount = weeklyTrend
        .map((point) => point.amount)
        .reduce((a, b) => a > b ? a : b);

    return BarChart(
      BarChartData(
        maxY: maxAmount == 0 ? 1 : maxAmount * 1.2,
        alignment: BarChartAlignment.spaceAround,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(enabled: true, touchCallback: (p0, p1) {}),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= weeklyTrend.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    weeklyTrend[index].label,
                    style: AppTypography.labelMd.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < weeklyTrend.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: weeklyTrend[i].amount,
                  width: _barWidth,
                  color: i == highestIndex
                      ? colorScheme.onSurface
                      : colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            ),
        ],
      ),
    );
  }

  int _highestIndex() {
    var highest = 0;
    for (var i = 1; i < weeklyTrend.length; i++) {
      if (weeklyTrend[i].amount > weeklyTrend[highest].amount) highest = i;
    }
    return highest;
  }
}
