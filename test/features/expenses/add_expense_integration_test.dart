import 'dart:io';

import 'package:fin_pilot/core/di/injector.dart';
import 'package:fin_pilot/features/expenses/data/models/expense_hive_model.dart';
import 'package:fin_pilot/features/expenses/presentation/cubit/add_expense_cubit.dart';
import 'package:fin_pilot/features/expenses/presentation/cubit/add_expense_state.dart';
import 'package:fin_pilot/hive_registrar.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';

/// Exercises the exact production wiring (setupInjector + the same Hive
/// box name main.dart opens) end-to-end, to prove the seam that changed in
/// this step: DI resolving a real Hive box through to an actual write.
void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('hive_integration_test');
    Hive.init(tempDir.path);
    Hive.registerAdapters();
    await Hive.openBox<ExpenseHiveModel>('expenses');
    setupInjector();
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('expenses', path: tempDir.path);
    await getIt.reset();
    await tempDir.delete(recursive: true);
  });

  test(
    'submitting through the real DI graph writes an expense to Hive',
    () async {
      final cubit = getIt<AddExpenseCubit>();

      cubit.amountChanged(25.5);
      cubit.descriptionChanged('Coffee');
      cubit.categoryChanged('Groceries');
      cubit.dateChanged(DateTime(2026, 7, 29));
      await cubit.submit();

      expect(cubit.state, const AddExpenseState.success());

      final box = Hive.box<ExpenseHiveModel>('expenses');
      expect(box.length, 1);
      expect(box.values.first.amount, 25.5);
      expect(box.values.first.description, 'Coffee');
    },
  );
}
