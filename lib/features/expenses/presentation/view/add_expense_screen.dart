import 'package:fin_pilot/core/di/injector.dart';
import 'package:fin_pilot/core/theme/app_spacing.dart';
import 'package:fin_pilot/core/theme/app_typography.dart';
import 'package:fin_pilot/features/expenses/presentation/cubit/add_expense_cubit.dart';
import 'package:fin_pilot/features/expenses/presentation/cubit/add_expense_state.dart';
import 'package:fin_pilot/features/expenses/presentation/widgets/amount_input.dart';
import 'package:fin_pilot/features/expenses/presentation/widgets/description_card.dart';
import 'package:fin_pilot/features/expenses/presentation/widgets/expense_category_dropdown.dart';
import 'package:fin_pilot/features/expenses/presentation/widgets/expense_date_picker.dart';
import 'package:fin_pilot/features/expenses/presentation/widgets/log_expense_button.dart';
import 'package:fin_pilot/features/expenses/presentation/widgets/receipt_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddExpenseCubit>(),
      child: const _AddExpenseView(),
    );
  }
}

class _AddExpenseView extends StatelessWidget {
  const _AddExpenseView();

  Future<void> _pickReceipt(BuildContext context, ImageSource source) async {
    final picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 80,
    );
    if (picked == null || !context.mounted) return;
    context.read<AddExpenseCubit>().receiptPicked(picked.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expenses', style: AppTypography.appBarBoldTitle),
        centerTitle: false,
      ),
      body: BlocListener<AddExpenseCubit, AddExpenseState>(
        listener: (context, state) {
          switch (state) {
            case AddExpenseSuccess():
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Expense added')));
              context.pop(true);
            case AddExpenseFailure(:final message):
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            case AddExpenseInitial() || AddExpenseSubmitting():
              break;
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AmountInput(
                  onChanged: (value) =>
                      context.read<AddExpenseCubit>().amountChanged(value),
                ),
                SizedBox(height: AppSpacing.lg),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: ExpenseCategoryDropDown(
                    onCategorySelected: (category) => context
                        .read<AddExpenseCubit>()
                        .categoryChanged(category),
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: DescriptionCard(
                    onChanged: (value) => context
                        .read<AddExpenseCubit>()
                        .descriptionChanged(value),
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: ReceiptPicker(
                    onCameraTap: () =>
                        _pickReceipt(context, ImageSource.camera),
                    onGalleryTap: () =>
                        _pickReceipt(context, ImageSource.gallery),
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: ExpenseDatePicker(
                    onDateSelected: (date) =>
                        context.read<AddExpenseCubit>().dateChanged(date),
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: context.read<AddExpenseCubit>().isValid,
                    builder: (context, isValid, _) {
                      return BlocBuilder<AddExpenseCubit, AddExpenseState>(
                        buildWhen: (previous, current) =>
                            previous.runtimeType != current.runtimeType,
                        builder: (context, state) {
                          final isSubmitting = state is AddExpenseSubmitting;
                          return LogExpenseButton(
                            onPressed: (!isValid || isSubmitting)
                                ? null
                                : () =>
                                      context.read<AddExpenseCubit>().submit(),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
