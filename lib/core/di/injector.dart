import 'package:dio/dio.dart';
import 'package:fin_pilot/core/network/api_client.dart';
import 'package:fin_pilot/flavour_config.dart';
import 'package:get_it/get_it.dart';
import 'package:fin_pilot/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:fin_pilot/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:fin_pilot/features/auth/data/datasources/auth_social_datasource.dart';
import 'package:fin_pilot/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fin_pilot/features/auth/domain/repositories/auth_repository.dart';
import 'package:fin_pilot/features/auth/domain/usecases/check_auth_status.dart';
import 'package:fin_pilot/features/auth/domain/usecases/login.dart';
import 'package:fin_pilot/features/auth/domain/usecases/logout.dart';
import 'package:fin_pilot/features/auth/domain/usecases/sign_in_with_apple.dart';
import 'package:fin_pilot/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:fin_pilot/features/auth/domain/usecases/signup.dart';
import 'package:fin_pilot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fin_pilot/features/dashboard/data/datasources/dashboard_local_datasource.dart';
import 'package:fin_pilot/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:fin_pilot/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:fin_pilot/features/dashboard/domain/usecases/get_dashboard_summary.dart';
import 'package:fin_pilot/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:fin_pilot/features/expenses/data/datasources/expense_local_datasource.dart';
import 'package:fin_pilot/features/expenses/data/models/expense_hive_model.dart';
import 'package:fin_pilot/features/expenses/data/repositories/expense_repository_impl.dart';
import 'package:fin_pilot/features/expenses/domain/repositories/expense_repository.dart';
import 'package:fin_pilot/features/expenses/domain/usecases/add_expense.dart';
import 'package:fin_pilot/features/expenses/presentation/cubit/add_expense_cubit.dart';
import 'package:hive_ce/hive.dart';

final getIt = GetIt.instance;

/// Registers every feature's dependencies. Call once from `main()` before
/// `runApp()`. New features add their own `_initX()` and call it here.
void setupInjector() {
  _initAuth();
  _initDashboard();
  _initExpenses();
}

void _initAuth() {
  getIt.registerLazySingleton<Box<String>>(
    () => Hive.box<String>('auth_tokens'),
  );
  getIt.registerLazySingleton(() => AuthLocalDataSource(getIt()));
  getIt.registerLazySingleton<Dio>(
    () => buildDio(
      baseUrl: AppEnvironment.baseUrl,
      getAccessToken: () => getIt<AuthLocalDataSource>().getAccessToken(),
    ),
  );
  getIt.registerLazySingleton(() => AuthRemoteDataSource(getIt()));
  getIt.registerLazySingleton(() => AuthSocialDataSource());
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remote: getIt(), local: getIt(), social: getIt()),
  );
  getIt.registerLazySingleton(() => CheckAuthStatusUseCase(getIt()));
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => SignupUseCase(getIt()));
  getIt.registerLazySingleton(() => SignInWithGoogleUseCase(getIt()));
  getIt.registerLazySingleton(() => SignInWithAppleUseCase(getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt()));
  // Registered as a singleton (not a factory, unlike other cubits/blocs)
  // because auth state is app-wide and the router's redirect logic needs
  // to observe the same instance every screen uses.
  getIt.registerLazySingleton(
    () => AuthBloc(
      checkAuthStatus: getIt(),
      login: getIt(),
      signup: getIt(),
      signInWithGoogle: getIt(),
      signInWithApple: getIt(),
      logout: getIt(),
    ),
  );
}

void _initDashboard() {
  getIt.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardHiveDataSource(getIt()),
  );
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => GetDashboardSummary(getIt()));
  getIt.registerFactory(() => DashboardCubit(getIt()));
}

void _initExpenses() {
  getIt.registerLazySingleton<Box<ExpenseHiveModel>>(
    () => Hive.box<ExpenseHiveModel>('expenses'),
  );
  getIt.registerLazySingleton<ExpenseLocalDataSource>(
    () => ExpenseHiveDataSource(getIt()),
  );
  getIt.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => AddExpenseUseCase(getIt()));
  getIt.registerFactory(() => AddExpenseCubit(getIt()));
}
