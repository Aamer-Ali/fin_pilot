import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fin_pilot/core/usecase/usecase.dart';
import 'package:fin_pilot/features/dashboard/domain/usecases/get_dashboard_summary.dart';
import 'package:fin_pilot/features/dashboard/presentation/cubit/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._getDashboardSummary)
    : super(const DashboardState.initial());

  final GetDashboardSummary _getDashboardSummary;

  Future<void> loadDashboard() async {
    emit(const DashboardState.loading());
    final result = await _getDashboardSummary(const NoParams());
    result.fold(
      (failure) => emit(DashboardState.error(failure.message)),
      (summary) => emit(DashboardState.loaded(summary)),
    );
  }
}
