import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/core/usecase/usecase.dart';
import 'package:fin_pilot/features/expenses/domain/entities/expense.dart';
import 'package:fin_pilot/features/expenses/domain/repositories/expense_repository.dart';

class AddExpenseUseCase extends UseCase<Expense, AddExpenseParams> {
  AddExpenseUseCase(this._repository);

  final ExpenseRepository _repository;

  @override
  Future<Either<Failure, Expense>> call(AddExpenseParams params) {
    final now = DateTime.now();
    return _repository.addExpense(
      Expense(
        id: now.microsecondsSinceEpoch.toString(),
        amount: params.amount,
        description: params.description,
        category: params.category,
        date: params.date,
        createdAt: now,
        receiptLocalPath: params.receiptLocalPath,
      ),
    );
  }
}

class AddExpenseParams extends Equatable {
  const AddExpenseParams({
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
    this.receiptLocalPath,
  });

  final double amount;
  final String description;
  final String category;
  final DateTime date;
  final String? receiptLocalPath;

  @override
  List<Object?> get props => [
    amount,
    description,
    category,
    date,
    receiptLocalPath,
  ];
}
