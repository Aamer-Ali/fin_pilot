import 'package:dartz/dartz.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/features/expenses/data/datasources/expense_local_datasource.dart';
import 'package:fin_pilot/features/expenses/data/models/expense_model.dart';
import 'package:fin_pilot/features/expenses/domain/entities/expense.dart';
import 'package:fin_pilot/features/expenses/domain/repositories/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  ExpenseRepositoryImpl(this._localDataSource);

  final ExpenseLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, Expense>> addExpense(Expense expense) async {
    try {
      final model = ExpenseModel.fromEntity(expense);
      await _localDataSource.addExpense(model);
      return Right(model);
    } catch (e) {
      return Left(Failure.unexpected(e.toString()));
    }
  }
}
