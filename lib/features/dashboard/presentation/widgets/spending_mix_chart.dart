import 'package:fin_pilot/core/theme/app_spacing.dart';
import 'package:fin_pilot/core/theme/app_typography.dart';
import 'package:fin_pilot/features/dashboard/domain/entities/category_spending.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Donut rendering of [DashboardSummary.spendingMix]. Stateless and
/// data-only — the parent card owns the heading/layout, this just draws
/// the ring, the outflow-percentage center label, and the legend, so it
/// only rebuilds when the values it was given actually change.
class SpendingMixChart extends StatelessWidget {
  const SpendingMixChart({
    super.key,
    required this.spendingMix,
    required this.outflowPercentage,
  });

  final List<CategorySpending> spendingMix;
  final double outflowPercentage;

  static const double _ringThickness = 28;

  /// Dark-to-light tonal ramp built from existing theme roles so section
  /// colors never fall outside the design system. Cycles if there are
  /// more categories than steps.
  List<Color> _palette(ColorScheme colorScheme) => [
    colorScheme.onSurface,
    colorScheme.secondary,
    colorScheme.outline,
    colorScheme.outlineVariant,
    colorScheme.surfaceContainerHigh,
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (spendingMix.isEmpty) {
      return Center(
        child: Text(
          "No spending yet",
          style: AppTypography.bodySm.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    final palette = _palette(colorScheme);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [

              PieChart(
                PieChartData(
                  centerSpaceRadius: 50,
                  sectionsSpace: 3,
                  pieTouchData: PieTouchData(enabled: true),
                  sections: [
                    for (var i = 0; i < spendingMix.length; i++)
                      PieChartSectionData(
                        value: spendingMix[i].percentage,
                        color: palette[i % palette.length],
                        radius: _ringThickness,
                        cornerRadius: 6,
                        showTitle: false,
                      ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Outflow".toUpperCase(),
                    style: AppTypography.labelMd.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    "${outflowPercentage.toStringAsFixed(0)}%",
                    style: AppTypography.headlineMd.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.xl),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.xs,
          children: [
            for (var i = 0; i < spendingMix.length; i++)
              _LegendEntry(
                color: palette[i % palette.length],
                label: spendingMix[i].category,
              ),
          ],
        ),
      ],
    );
  }
}

class _LegendEntry extends StatelessWidget {
  const _LegendEntry({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: AppTypography.bodySm.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}