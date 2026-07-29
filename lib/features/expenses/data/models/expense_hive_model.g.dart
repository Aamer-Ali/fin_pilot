// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseHiveModelAdapter extends TypeAdapter<ExpenseHiveModel> {
  @override
  final typeId = 0;

  @override
  ExpenseHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseHiveModel(
      id: fields[0] as String,
      amount: (fields[1] as num).toDouble(),
      description: fields[2] as String,
      category: fields[3] as String,
      date: fields[5] as DateTime,
      isSynced: fields[6] as bool,
      createdAt: fields[7] as DateTime,
      receiptLocalPath: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.receiptLocalPath)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.isSynced)
      ..writeByte(7)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
