import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:menu_desktop/AdminPage/addDrink.dart';
import 'package:menu_desktop/AdminPage/navAdmin.dart';
import 'package:menu_desktop/box.dart';
import 'package:menu_desktop/menu_desktop_db.dart';

class DrinkAdmin extends StatefulWidget {
  Future<void> openBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MenuDrinkAdapter());
    menuDrinkBox = await Hive.openBox<MenuDrink>('menudrink');
  }

  @override
  _DrinkAdminState createState() => _DrinkAdminState();
}

class _DrinkAdminState extends State<DrinkAdmin> {
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
    MenuDrink dbDrink = menuDrinkBox.getAt(index);

    nameController.text = dbDrink.name;
    descriptionController.text = dbDrink.description;
    priceController.text = dbDrink.price.toString();

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
                MenuDrink updatedPerson = MenuDrink(
                  name: nameController.text,
                  description: descriptionController.text,
                  price: double.parse(priceController.text),
                );

                setState(() {
                  menuDrinkBox.putAt(index, updatedPerson);
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
                    Navigator.of(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FormDrink()),
                    );
                  },
                ),
              ),
            ),
          ],
          backgroundColor: const Color(0xFF5E2D71),
          title: const Center(
              child: Text(
            'Drinks',
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
            itemCount: menuDrinkBox.length,
            itemBuilder: (context, index) {
              MenuDrink dbDrink = menuDrinkBox.getAt(index);
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
                            dbDrink.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${dbDrink.price.toString()} €',
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
                                            'Are you sure you want to delete ${dbDrink.name}?'),
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
                                                menuDrinkBox.deleteAt(index);
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
                        dbDrink.description,
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
