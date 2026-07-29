import 'package:fin_pilot/core/theme/app_spacing.dart';
import 'package:fin_pilot/core/theme/app_theme.dart';
import 'package:fin_pilot/core/theme/app_typography.dart';
import 'package:fin_pilot/features/expenses/presentation/widgets/amount_input.dart';
import 'package:fin_pilot/features/expenses/presentation/widgets/description_card.dart';
import 'package:fin_pilot/features/expenses/presentation/widgets/expense_date_picker.dart';
import 'package:fin_pilot/features/expenses/presentation/widgets/log_expense_button.dart';
import 'package:fin_pilot/features/expenses/presentation/widgets/receipt_picker.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expenses', style: AppTypography.appBarBoldTitle,),
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainer),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AmountInput(),
            SizedBox(height: AppSpacing.lg),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: DescriptionCard(),
            ),
            SizedBox(height: AppSpacing.lg),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: ReceiptPicker(),
            ),
            SizedBox(height: AppSpacing.lg),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: ExpenseDatePicker(),
            ),
            SizedBox(height: AppSpacing.lg),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: LogExpenseButton(),
            ),
          ],
        ),
      ),
    );
  }
}
