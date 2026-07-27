import 'package:get_it/get_it.dart';
import 'package:fin_pilot/features/dashboard/data/datasources/dashboard_local_datasource.dart';
import 'package:fin_pilot/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:fin_pilot/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:fin_pilot/features/dashboard/domain/usecases/get_dashboard_summary.dart';
import 'package:fin_pilot/features/dashboard/presentation/cubit/dashboard_cubit.dart';

final getIt = GetIt.instance;

/// Registers every feature's dependencies. Call once from `main()` before
/// `runApp()`. New features add their own `_initX()` and call it here.
void setupInjector() {
  _initDashboard();
}

void _initDashboard() {
  getIt.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardDummyDataSource(),
  );
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => GetDashboardSummary(getIt()));
  getIt.registerFactory(() => DashboardCubit(getIt()));
}