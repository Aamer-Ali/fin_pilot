import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fin_pilot/features/dashboard/domain/entities/dashboard_summary.dart';

part 'dashboard_state.freezed.dart';

@freezed
sealed class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = DashboardInitial;
  const factory DashboardState.loading() = DashboardLoading;
  const factory DashboardState.loaded(DashboardSummary summary) =
      DashboardLoaded;
  const factory DashboardState.error(String message) = DashboardError;
}
