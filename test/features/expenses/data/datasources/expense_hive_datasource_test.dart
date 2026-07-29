import 'dart:io';

import 'package:fin_pilot/features/expenses/data/datasources/expense_local_datasource.dart';
import 'package:fin_pilot/features/expenses/data/models/expense_hive_model.dart';
import 'package:fin_pilot/features/expenses/data/models/expense_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';

void main() {
  late Directory tempDir;
  late Box<ExpenseHiveModel> box;
  late ExpenseHiveDataSource dataSource;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('hive_test');
    Hive.init(tempDir.path);
    Hive.registerAdapter(ExpenseHiveModelAdapter());
    box = await Hive.openBox<ExpenseHiveModel>('expenses_test');
    dataSource = ExpenseHiveDataSource(box);
  });

  tearDown(() async {
    await box.close();
    await Hive.deleteBoxFromDisk('expenses_test', path: tempDir.path);
    await tempDir.delete(recursive: true);
  });

  test('addExpense stores the expense in the box under its id', () async {
    final expense = ExpenseModel(
      id: '1',
      amount: 25.5,
      description: 'Groceries',
      category: 'General',
      date: DateTime(2026, 7, 29),
      createdAt: DateTime(2026, 7, 29),
    );

    await dataSource.addExpense(expense);

    final stored = box.get('1');
    expect(stored, isNotNull);
    expect(stored!.id, '1');
    expect(stored.amount, 25.5);
    expect(stored.description, 'Groceries');
    expect(stored.category, 'General');
    expect(stored.isSynced, false);
  });
}
