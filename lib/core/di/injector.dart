import 'package:get_it/get_it.dart';
import 'package:fin_pilot/features/dashboard/data/datasources/dashboard_local_datasource.dart';
import 'package:fin_pilot/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:fin_pilot/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:fin_pilot/features/dashboard/domain/usecases/get_dashboard_summary.dart';
import 'package:fin_pilot/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:fin_pilot/features/expenses/data/datasources/expense_local_datasource.dart';
import 'package:fin_pilot/features/expenses/data/repositories/expense_repository_impl.dart';
import 'package:fin_pilot/features/expenses/domain/repositories/expense_repository.dart';
import 'package:fin_pilot/features/expenses/domain/usecases/add_expense.dart';
import 'package:fin_pilot/features/expenses/presentation/cubit/add_expense_cubit.dart';

final getIt = GetIt.instance;

/// Registers every feature's dependencies. Call once from `main()` before
/// `runApp()`. New features add their own `_initX()` and call it here.
void setupInjector() {
  _initDashboard();
  _initExpenses();
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

void _initExpenses() {
  getIt.registerLazySingleton<ExpenseLocalDataSource>(
    () => ExpenseDummyDataSource(),
  );
  getIt.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => AddExpenseUseCase(getIt()));
  getIt.registerFactory(() => AddExpenseCubit(getIt()));
}