import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/di/injector.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/expenses/data/models/expense_hive_model.dart';
import 'hive_registrar.g.dart';

void mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Opens Hive's on-device storage and teaches it how to read/write our
  // model types (registerAdapters() is generated — see hive_registrar.g.dart
  // — and picks up every @HiveType class automatically).
  await Hive.initFlutter();
  Hive.registerAdapters();
  await Hive.openBox<ExpenseHiveModel>('expenses');
  // Plain (untyped) box for auth tokens — deliberately not secure storage;
  // see auth_local_datasource.dart for why.
  await Hive.openBox<String>('auth_tokens');

  setupInjector();
  getIt<AuthBloc>().add(const AppStarted());
  runApp(const App());
}
