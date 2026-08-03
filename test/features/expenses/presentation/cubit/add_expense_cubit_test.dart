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

  void fillValidForm(AddExpenseCubit cubit) {
    cubit
      ..amountChanged(42)
      ..descriptionChanged('Coffee')
      ..categoryChanged('Groceries')
      ..dateChanged(date);
  }

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

  test('isValid starts false', () {
    expect(buildCubit().isValid.value, isFalse);
  });

  test(
    'isValid becomes true once amount, description, category, and date are all set',
    () {
      final cubit = buildCubit();
      fillValidForm(cubit);
      expect(cubit.isValid.value, isTrue);
    },
  );

  test('isValid stays false when any single field is missing', () {
    final cubit = buildCubit();
    cubit
      ..amountChanged(42)
      ..descriptionChanged('Coffee')
      ..categoryChanged('Groceries');
    // date never set
    expect(cubit.isValid.value, isFalse);
  });

  test('isValid stays false when amount is zero', () {
    final cubit = buildCubit();
    cubit
      ..amountChanged(0)
      ..descriptionChanged('Coffee')
      ..categoryChanged('Groceries')
      ..dateChanged(date);
    expect(cubit.isValid.value, isFalse);
  });

  test('isValid stays false when description is blank', () {
    final cubit = buildCubit();
    cubit
      ..amountChanged(42)
      ..descriptionChanged('   ')
      ..categoryChanged('Groceries')
      ..dateChanged(date);
    expect(cubit.isValid.value, isFalse);
  });

  blocTest<AddExpenseCubit, AddExpenseState>(
    'submit does nothing and never calls the use case while the form is invalid',
    build: buildCubit,
    act: (cubit) => cubit.submit(),
    expect: () => const <AddExpenseState>[],
    verify: (_) {
      verifyNever(() => addExpense(any()));
    },
  );

  blocTest<AddExpenseCubit, AddExpenseState>(
    'submit emits [submitting, success] when the use case succeeds',
    setUp: () {
      when(() => addExpense(any())).thenAnswer((_) async => Right(expense));
    },
    build: buildCubit,
    act: (cubit) {
      fillValidForm(cubit);
      cubit.submit();
    },
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
    act: (cubit) {
      fillValidForm(cubit);
      cubit.submit();
    },
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
      ..categoryChanged('Groceries')
      ..dateChanged(date)
      ..receiptPicked('/tmp/receipt.jpg')
      ..submit(),
    verify: (_) {
      verify(
        () => addExpense(
          AddExpenseParams(
            amount: 42,
            description: 'Coffee',
            category: 'Groceries',
            date: date,
            receiptLocalPath: '/tmp/receipt.jpg',
          ),
        ),
      ).called(1);
    },
  );
}
