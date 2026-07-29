import 'package:fin_pilot/core/di/injector.dart';
import 'package:fin_pilot/core/theme/app_radius.dart';
import 'package:fin_pilot/core/theme/app_spacing.dart';
import 'package:fin_pilot/core/theme/app_typography.dart';
import 'package:fin_pilot/core/utils/currency_formatter.dart';
import 'package:fin_pilot/core/utils/date_formatter.dart';
import 'package:fin_pilot/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:fin_pilot/features/dashboard/domain/entities/recent_activity.dart';
import 'package:fin_pilot/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:fin_pilot/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:fin_pilot/features/dashboard/presentation/widgets/analytics_pulse_chart.dart';
import 'package:fin_pilot/features/dashboard/presentation/widgets/spending_mix_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DashboardCubit>()..loadDashboard(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FinPilot"),
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSpacing.md),
            child: Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return switch (state) {
            DashboardInitial() || DashboardLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            DashboardError(:final message) => Center(
              child: Text(message, style: AppTypography.bodyLg),
            ),
            DashboardLoaded(:final summary) => _DashboardContent(
              summary: summary,
            ),
          };
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          final expenseAdded = await context.push<bool>('/add-expense');
          if (expenseAdded == true && context.mounted) {
            context.read<DashboardCubit>().loadDashboard();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Container(
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width / 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.md,
          children: [
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       "Total Balance".toUpperCase(),
            //       style: AppTypography.labelMd,
            //     ),
            //     Row(
            //       children: [
            //         Icon(Icons.currency_rupee),
            //         Text(
            //           formatCurrency(summary.totalBalance),
            //           style: AppTypography.headlineLg,
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Monthly Spending".toUpperCase(),
                  style: AppTypography.labelMd,
                ),
                Row(
                  children: [
                    Icon(Icons.currency_rupee),
                    Text(
                      formatCurrency(summary.monthlySpending),
                      style: AppTypography.headlineLgMobile,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 1.2,
              padding: EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Spending Mix", style: AppTypography.headlineMd),
                  SizedBox(height: AppSpacing.xl),
                  Expanded(
                    child: SpendingMixChart(
                      spendingMix: summary.spendingMix,
                      outflowPercentage: summary.outflowPercentage,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 1.2,
              padding: EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Analytics Pulse", style: AppTypography.headlineMd),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    summary.insightText,
                    style: AppTypography.bodySm.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: AppSpacing.md),
                  Expanded(
                    child: AnalyticsPulseChart(
                      weeklyTrend: summary.weeklyTrend,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recent Activity", style: AppTypography.bodyLg),
                InkResponse(
                  onTap: () {},
                  child: Row(
                    spacing: 8,
                    children: [
                      Text("View All", style: AppTypography.labelMd),
                      Icon(Icons.chevron_right, size: AppSpacing.md),
                    ],
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: summary.recentActivities.length > 4
                  ? 4
                  : summary.recentActivities.length,
              itemBuilder: (context, index) {
                final activity = summary.recentActivities[index];
                return _RecentActivityTile(activity: activity);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentActivityTile extends StatelessWidget {
  const _RecentActivityTile({required this.activity});

  final RecentActivity activity;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final amountColor = activity.isIncome
        ? colorScheme.onTertiaryContainer
        : colorScheme.onSurfaceVariant;
    final sign = activity.isIncome ? '+' : '-';

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        activity.title,
        style: AppTypography.bodyLg.copyWith(color: colorScheme.onSurface),
      ),
      subtitle: Text(
        "${activity.description} · ${formatRelativeDate(activity.date)}",
        style: AppTypography.bodySm.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            sign,
            style: AppTypography.dataMono.copyWith(color: amountColor),
          ),
          Icon(Icons.currency_rupee, size: 16),
          Text(
            formatCurrency(activity.amount),
            style: AppTypography.dataMono.copyWith(color: amountColor),
          ),
        ],
      ),
    );
  }
}
