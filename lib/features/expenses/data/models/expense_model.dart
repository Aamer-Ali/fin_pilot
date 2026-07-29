import 'package:fin_pilot/features/expenses/domain/entities/expense.dart';

class ExpenseModel extends Expense {
  const ExpenseModel({
    required super.id,
    required super.amount,
    required super.description,
    required super.category,
    required super.date,
    required super.createdAt,
    super.receiptLocalPath,
  });

  factory ExpenseModel.fromEntity(Expense expense) => ExpenseModel(
    id: expense.id,
    amount: expense.amount,
    description: expense.description,
    category: expense.category,
    date: expense.date,
    createdAt: expense.createdAt,
    receiptLocalPath: expense.receiptLocalPath,
  );
}
