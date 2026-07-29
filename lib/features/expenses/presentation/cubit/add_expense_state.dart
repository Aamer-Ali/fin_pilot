import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_expense_state.freezed.dart';

@freezed
sealed class AddExpenseState with _$AddExpenseState {
  const factory AddExpenseState.initial() = AddExpenseInitial;
  const factory AddExpenseState.submitting() = AddExpenseSubmitting;
  const factory AddExpenseState.success() = AddExpenseSuccess;
  const factory AddExpenseState.failure(String message) = AddExpenseFailure;
}
