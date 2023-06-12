import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:menu_desktop/box.dart';
import 'package:menu_desktop/menu_desktop_db.dart';
import 'package:menu_desktop/main.dart';
import 'package:menu_desktop/AdminPage/drinkAdmin.dart';

class FormDrink extends StatefulWidget {
  @override
  AddDrink createState() => AddDrink();
}

class AddDrink extends State<FormDrink> {
  Future<void> openBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MenuDrinkAdapter());
    menuDrinkBox = await Hive.openBox<MenuDrink>('menudrink');
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 220, 227, 241),
        //drawer: MenuNavBarAdmin(),
        appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content:
                            const Text('Are you sure you want to disconnect?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                            },
                            child: const Text('Disconnect'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
            backgroundColor: const Color(0xFF5E2D71),
            title: const Center(
                child: Text(
              'shapeMyMeal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ))),
        body: Column(
          children: [
            PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: AppBar(
                automaticallyImplyLeading: false,
                title: const Center(child: Text('Add a Drink')),
                backgroundColor: const Color.fromARGB(255, 216, 186, 228),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF8E44AD),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextFormField(
                                  controller: nameController,
                                  maxLength: 40,
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 35),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextFormField(
                                  controller: descriptionController,
                                  maxLength: 120,
                                  decoration: const InputDecoration(
                                    labelText: 'Description',
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 35),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextFormField(
                                  controller: priceController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(
                                        r'[0-9!@#\$%\^&\*\(\)_\+\-=\[\]{};:"\\|,.<>\/?]+')),
                                  ],
                                  maxLength: 6,
                                  decoration: const InputDecoration(
                                    labelText: 'Price (€)',
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 35),
                              SizedBox(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      menuDrinkBox.put(
                                          'key_${nameController.text}',
                                          MenuDrink(
                                              name: nameController.text,
                                              description:
                                                  descriptionController.text,
                                              price: double.parse(
                                                  priceController.text)));
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DrinkAdmin()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(200, 50),
                                      backgroundColor: const Color.fromARGB(
                                          255, 216, 186, 228)),
                                  child: const Text('Add'),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ],
        ));
  }
}
