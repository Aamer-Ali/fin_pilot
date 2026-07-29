import 'package:dartz/dartz.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/features/expenses/domain/entities/expense.dart';

abstract class ExpenseRepository {
  Future<Either<Failure, Expense>> addExpense(Expense expense);
}
