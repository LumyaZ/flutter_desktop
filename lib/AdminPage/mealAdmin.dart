import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:menu_desktop/AdminPage/addMeal.dart';
import 'package:menu_desktop/AdminPage/navAdmin.dart';
import 'package:menu_desktop/box.dart';
import 'package:menu_desktop/menu_desktop_db.dart';

class MealAdmin extends StatefulWidget {
  Future<void> openBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MenuMealAdapter());
    menuMealBox = await Hive.openBox<MenuMeal>('menumeal');
  }

  @override
  _MealAdminState createState() => _MealAdminState();
}

class _MealAdminState extends State<MealAdmin> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void showEditDialog(int index) {
    MenuMeal dbMeal = menuMealBox.getAt(index);

    nameController.text = dbMeal.name;
    descriptionController.text = dbMeal.description;
    priceController.text = dbMeal.price.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Person'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                maxLength: 40,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                maxLength: 120,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'description',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceController,
                maxLength: 6,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                MenuMeal updatedPerson = MenuMeal(
                  name: nameController.text,
                  description: descriptionController.text,
                  price: double.parse(priceController.text),
                );

                setState(() {
                  menuMealBox.putAt(index, updatedPerson);
                });

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarAdmin(),
      appBar: AppBar(
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FormMeal()),
                    );
                  },
                ),
              ),
            ),
          ],
          backgroundColor: const Color(0xFF5E2D71),
          title: const Center(
              child: Text(
            'Meals',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ))),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView.builder(
            itemCount: menuMealBox.length,
            itemBuilder: (context, index) {
              MenuMeal dbmeal = menuMealBox.getAt(index);
              return Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8E44AD),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dbmeal.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${dbmeal.price.toString()} €',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showEditDialog(index);
                                },
                                icon: const Icon(Icons.edit),
                                color: Colors.yellow,
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Confirmation'),
                                        content: Text(
                                            'Are you sure you want to delete ${dbmeal.name}?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                menuMealBox.deleteAt(index);
                                              });
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        dbmeal.description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ]);
            },
          ),
        ),
      ),
    );
  }
}
