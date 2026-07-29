import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fin_pilot/core/error/failures.dart';
import 'package:fin_pilot/features/expenses/domain/entities/expense.dart';
import 'package:fin_pilot/features/expenses/domain/usecases/add_expense.dart';
import 'package:fin_pilot/features/expenses/presentation/cubit/add_expense_cubit.dart';
import 'package:fin_pilot/features/expenses/presentation/cubit/add_expense_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddExpenseUseCase extends Mock implements AddExpenseUseCase {}

void main() {
  late MockAddExpenseUseCase addExpense;
  final date = DateTime(2026, 7, 29);

  final expense = Expense(
    id: '1',
    amount: 10,
    description: 'Coffee',
    category: 'General',
    date: date,
    createdAt: date,
  );

  setUpAll(() {
    registerFallbackValue(
      AddExpenseParams(
        amount: 0,
        description: '',
        category: 'General',
        date: date,
      ),
    );
  });

  setUp(() {
    addExpense = MockAddExpenseUseCase();
  });

  AddExpenseCubit buildCubit() => AddExpenseCubit(addExpense);

  test('initial state is AddExpenseState.initial', () {
    expect(buildCubit().state, const AddExpenseState.initial());
  });

  blocTest<AddExpenseCubit, AddExpenseState>(
    'submit emits [submitting, success] when the use case succeeds',
    setUp: () {
      when(() => addExpense(any())).thenAnswer((_) async => Right(expense));
    },
    build: buildCubit,
    act: (cubit) => cubit.submit(),
    expect: () => const [
      AddExpenseState.submitting(),
      AddExpenseState.success(),
    ],
  );

  blocTest<AddExpenseCubit, AddExpenseState>(
    'submit emits [submitting, failure] when the use case fails',
    setUp: () {
      when(() => addExpense(any())).thenAnswer(
        (_) async => const Left(Failure.unexpected('Could not save expense')),
      );
    },
    build: buildCubit,
    act: (cubit) => cubit.submit(),
    expect: () => const [
      AddExpenseState.submitting(),
      AddExpenseState.failure('Could not save expense'),
    ],
  );

  blocTest<AddExpenseCubit, AddExpenseState>(
    'submit passes the accumulated field values to the use case',
    setUp: () {
      when(() => addExpense(any())).thenAnswer((_) async => Right(expense));
    },
    build: buildCubit,
    act: (cubit) => cubit
      ..amountChanged(42)
      ..descriptionChanged('Coffee')
      ..dateChanged(date)
      ..receiptPicked('/tmp/receipt.jpg')
      ..submit(),
    verify: (_) {
      verify(
        () => addExpense(
          AddExpenseParams(
            amount: 42,
            description: 'Coffee',
            category: 'General',
            date: date,
            receiptLocalPath: '/tmp/receipt.jpg',
          ),
        ),
      ).called(1);
    },
  );
}
