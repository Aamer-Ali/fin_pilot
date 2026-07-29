import 'package:hive_ce/hive.dart';

part 'expense_hive_model.g.dart';

/// The exact shape stored on disk in the "expenses" Hive box (CLAUDE.md
/// §5). Field numbers are permanent once shipped — never reuse or reorder
/// them, only add new ones with the next free number.
@HiveType(typeId: 0)
class ExpenseHiveModel {
  ExpenseHiveModel({
    required this.id,
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
    required this.isSynced,
    required this.createdAt,
    this.receiptLocalPath,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final String? receiptLocalPath;

  @HiveField(5)
  final DateTime date;

  @HiveField(6)
  final bool isSynced;

  @HiveField(7)
  final DateTime createdAt;
}
