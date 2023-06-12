// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_desktop_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MenuMealAdapter extends TypeAdapter<MenuMeal> {
  @override
  final int typeId = 1;

  @override
  MenuMeal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuMeal(
      name: fields[0] as String,
      description: fields[1] as String,
      price: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MenuMeal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuMealAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MenuAccompaniementAdapter extends TypeAdapter<MenuAccompaniement> {
  @override
  final int typeId = 2;

  @override
  MenuAccompaniement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuAccompaniement(
      name: fields[0] as String,
      description: fields[1] as String,
      price: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MenuAccompaniement obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuAccompaniementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MenuDrinkAdapter extends TypeAdapter<MenuDrink> {
  @override
  final int typeId = 3;

  @override
  MenuDrink read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuDrink(
      name: fields[0] as String,
      description: fields[1] as String,
      price: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MenuDrink obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuDrinkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
