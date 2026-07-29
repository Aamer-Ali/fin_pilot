import 'package:fin_pilot/features/expenses/domain/usecases/add_expense.dart';
import 'package:fin_pilot/features/expenses/presentation/cubit/add_expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  AddExpenseCubit(this._addExpense) : super(const AddExpenseState.initial());

  final AddExpenseUseCase _addExpense;

  double _amount = 0;
  String _description = '';
  final String _category = 'General';
  DateTime _date = DateTime.now();
  String? _receiptLocalPath;

  void amountChanged(double amount) => _amount = amount;

  void descriptionChanged(String description) => _description = description;

  void dateChanged(DateTime date) => _date = date;

  void receiptPicked(String? path) => _receiptLocalPath = path;

  Future<void> submit() async {
    emit(const AddExpenseState.submitting());

    final result = await _addExpense(
      AddExpenseParams(
        amount: _amount,
        description: _description,
        category: _category,
        date: _date,
        receiptLocalPath: _receiptLocalPath,
      ),
    );

    result.fold(
      (failure) => emit(AddExpenseState.failure(failure.message)),
      (_) => emit(const AddExpenseState.success()),
    );
  }
}
