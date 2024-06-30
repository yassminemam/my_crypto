// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_holding.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHoldingAdapter extends TypeAdapter<UserHolding> {
  @override
  final int typeId = 0;

  @override
  UserHolding read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserHolding(
      name: fields[0] as String?,
      symbol: fields[1] as String?,
      quantity: fields[2] as double?,
      currentPrice: fields[3] as double?,
      totalPrice: fields[4] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, UserHolding obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.currentPrice)
      ..writeByte(4)
      ..write(obj.totalPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserHoldingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
