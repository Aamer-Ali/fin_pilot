import 'package:fin_pilot/features/dashboard/domain/entities/recent_activity.dart';

class RecentActivityModel {
  const RecentActivityModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.amount,
    required this.isIncome,
  });

  factory RecentActivityModel.fromJson(Map<String, dynamic> json) {
    return RecentActivityModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      amount: (json['amount'] as num).toDouble(),
      isIncome: json['isIncome'] as bool,
    );
  }

  final String id;
  final String title;
  final String description;
  final DateTime date;
  final double amount;
  final bool isIncome;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date.toIso8601String(),
    'amount': amount,
    'isIncome': isIncome,
  };

  RecentActivity toEntity() => RecentActivity(
    id: id,
    title: title,
    description: description,
    date: date,
    amount: amount,
    isIncome: isIncome,
  );
}