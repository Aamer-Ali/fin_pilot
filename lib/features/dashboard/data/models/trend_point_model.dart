import 'package:fin_pilot/features/dashboard/domain/entities/trend_point.dart';

class TrendPointModel {
  const TrendPointModel({required this.label, required this.amount});

  factory TrendPointModel.fromJson(Map<String, dynamic> json) {
    return TrendPointModel(
      label: json['label'] as String,
      amount: (json['amount'] as num).toDouble(),
    );
  }

  final String label;
  final double amount;

  Map<String, dynamic> toJson() => {'label': label, 'amount': amount};

  TrendPoint toEntity() => TrendPoint(label: label, amount: amount);
}