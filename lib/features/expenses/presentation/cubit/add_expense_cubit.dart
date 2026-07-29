import 'package:fin_pilot/features/expenses/domain/usecases/add_expense.dart';
import 'package:fin_pilot/features/expenses/presentation/cubit/add_expense_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  AddExpenseCubit(this._addExpense) : super(const AddExpenseState.initial());

  final AddExpenseUseCase _addExpense;

  /// Live form validity — amount, category, description, and date are all
  /// mandatory. Separate from [AddExpenseState] on purpose: that state only
  /// tracks submission status, not field values.
  final ValueNotifier<bool> isValid = ValueNotifier(false);

  double _amount = 0;
  String _description = '';
  String? _category;
  DateTime? _date;
  String? _receiptLocalPath;

  void amountChanged(double amount) {
    _amount = amount;
    _recomputeValidity();
  }

  void descriptionChanged(String description) {
    _description = description;
    _recomputeValidity();
  }

  void categoryChanged(String category) {
    _category = category;
    _recomputeValidity();
  }

  void dateChanged(DateTime date) {
    _date = date;
    _recomputeValidity();
  }

  void receiptPicked(String? path) => _receiptLocalPath = path;

  void _recomputeValidity() {
    isValid.value =
        _amount > 0 &&
        _description.trim().isNotEmpty &&
        _category != null &&
        _date != null;
  }

  Future<void> submit() async {
    if (!isValid.value) return;

    emit(const AddExpenseState.submitting());

    final result = await _addExpense(
      AddExpenseParams(
        amount: _amount,
        description: _description,
        category: _category!,
        date: _date!,
        receiptLocalPath: _receiptLocalPath,
      ),
    );

    result.fold(
      (failure) => emit(AddExpenseState.failure(failure.message)),
      (_) => emit(const AddExpenseState.success()),
    );
  }

  @override
  Future<void> close() {
    isValid.dispose();
    return super.close();
  }
}
