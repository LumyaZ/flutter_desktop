import 'package:hive/hive.dart';

part 'menu_desktop_db.g.dart';

@HiveType(typeId: 1)
class MenuMeal {
  MenuMeal({
    required this.name,
    required this.description,
    required this.price,
  });
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  double price;
}

@HiveType(typeId: 2)
class MenuAccompaniement {
  MenuAccompaniement({
    required this.name,
    required this.description,
    required this.price,
  });
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  double price;
}

@HiveType(typeId: 3)
class MenuDrink {
  MenuDrink({
    required this.name,
    required this.description,
    required this.price,
  });
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  double price;
}
