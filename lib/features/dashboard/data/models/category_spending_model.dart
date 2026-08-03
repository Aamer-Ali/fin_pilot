import 'package:fin_pilot/features/dashboard/domain/entities/category_spending.dart';

class CategorySpendingModel {
  const CategorySpendingModel({
    required this.category,
    required this.amount,
    required this.percentage,
  });

  factory CategorySpendingModel.fromJson(Map<String, dynamic> json) {
    return CategorySpendingModel(
      category: json['category'] as String,
      amount: (json['amount'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
    );
  }

  final String category;
  final double amount;
  final double percentage;

  Map<String, dynamic> toJson() => {
    'category': category,
    'amount': amount,
    'percentage': percentage,
  };

  CategorySpending toEntity() => CategorySpending(
    category: category,
    amount: amount,
    percentage: percentage,
  );
}
