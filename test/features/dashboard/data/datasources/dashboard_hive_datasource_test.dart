import 'dart:io';

import 'package:fin_pilot/features/dashboard/data/datasources/dashboard_local_datasource.dart';
import 'package:fin_pilot/features/expenses/data/models/expense_hive_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';

void main() {
  late Directory tempDir;
  late Box<ExpenseHiveModel> box;
  late DashboardHiveDataSource dataSource;

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day, 10);

  ExpenseHiveModel expense({
    required String id,
    required double amount,
    required String category,
    required DateTime date,
    String description = '',
  }) {
    return ExpenseHiveModel(
      id: id,
      amount: amount,
      description: description,
      category: category,
      date: date,
      isSynced: false,
      createdAt: date,
    );
  }

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('dashboard_hive_test');
    Hive.init(tempDir.path);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ExpenseHiveModelAdapter());
    }
    box = await Hive.openBox<ExpenseHiveModel>('dashboard_expenses_test');
    dataSource = DashboardHiveDataSource(box);
  });

  tearDown(() async {
    await box.close();
    await Hive.deleteBoxFromDisk('dashboard_expenses_test', path: tempDir.path);
    await tempDir.delete(recursive: true);
  });

  test('returns zeroed-out summary when there are no expenses', () async {
    final summary = await dataSource.getDashboardSummary();

    expect(summary.monthlySpending, 0);
    expect(summary.spendingMix, isEmpty);
    expect(summary.recentActivities, isEmpty);
    expect(summary.weeklyTrend, hasLength(7));
    expect(summary.weeklyTrend.every((point) => point.amount == 0), isTrue);
  });

  test('aggregates this month\'s expenses into spending mix + total', () async {
    await box.putAll({
      'e1': expense(
        id: 'e1',
        amount: 100,
        category: 'Food',
        date: today,
        description: 'Groceries',
      ),
      'e2': expense(id: 'e2', amount: 50, category: 'Food', date: today),
      'e3': expense(id: 'e3', amount: 150, category: 'Transport', date: today),
    });

    final summary = await dataSource.getDashboardSummary();

    expect(summary.monthlySpending, 300);
    expect(summary.spendingMix, hasLength(2));

    final transport = summary.spendingMix.firstWhere(
      (c) => c.category == 'Transport',
    );
    expect(transport.amount, 150);
    expect(transport.percentage, 50);

    final food = summary.spendingMix.firstWhere((c) => c.category == 'Food');
    expect(food.amount, 150);
    expect(food.percentage, 50);
  });

  test(
    'excludes expenses from a different month from monthly totals',
    () async {
      final lastMonth = DateTime(today.year, today.month - 1, 15);
      await box.putAll({
        'e1': expense(id: 'e1', amount: 100, category: 'Food', date: today),
        'e2': expense(id: 'e2', amount: 999, category: 'Food', date: lastMonth),
      });

      final summary = await dataSource.getDashboardSummary();

      expect(summary.monthlySpending, 100);
    },
  );

  test('recentActivities returns newest-first, capped at 5', () async {
    for (var i = 0; i < 7; i++) {
      await box.put(
        'e$i',
        expense(
          id: 'e$i',
          amount: i.toDouble(),
          category: 'General',
          date: today.subtract(Duration(days: i)),
          description: 'Item $i',
        ),
      );
    }

    final summary = await dataSource.getDashboardSummary();

    expect(summary.recentActivities, hasLength(5));
    expect(summary.recentActivities.first.title, 'Item 0');
    expect(summary.recentActivities.last.title, 'Item 4');
  });
}
