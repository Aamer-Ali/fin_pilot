import 'package:fin_pilot/features/expenses/data/models/expense_hive_model.dart';
import 'package:fin_pilot/features/expenses/data/models/expense_model.dart';
import 'package:hive_ce/hive.dart';

abstract class ExpenseLocalDataSource {
  Future<void> addExpense(ExpenseModel expense);
}

class ExpenseHiveDataSource implements ExpenseLocalDataSource {
  ExpenseHiveDataSource(this._box);

  final Box<ExpenseHiveModel> _box;

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    await _box.put(expense.id, _toHiveModel(expense));
  }

  ExpenseHiveModel _toHiveModel(ExpenseModel expense) => ExpenseHiveModel(
    id: expense.id,
    amount: expense.amount,
    description: expense.description,
    category: expense.category,
    date: expense.date,
    isSynced: false,
    createdAt: expense.createdAt,
    receiptLocalPath: expense.receiptLocalPath,
  );
}
