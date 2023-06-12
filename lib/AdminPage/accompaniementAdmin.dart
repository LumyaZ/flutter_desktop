import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:menu_desktop/AdminPage/addAccompaniement.dart';
import 'package:menu_desktop/AdminPage/navAdmin.dart';
import 'package:menu_desktop/box.dart';
import 'package:menu_desktop/menu_desktop_db.dart';

class AccompaniementAdmin extends StatefulWidget {
  Future<void> openBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MenuAccompaniementAdapter());
    menuAccompaniementBox =
        await Hive.openBox<MenuAccompaniement>('menuaccompaniement');
  }

  @override
  _AccompaniementAdminState createState() => _AccompaniementAdminState();
}

class _AccompaniementAdminState extends State<AccompaniementAdmin> {
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
    MenuAccompaniement dbAccompaniement = menuAccompaniementBox.getAt(index);

    nameController.text = dbAccompaniement.name;
    descriptionController.text = dbAccompaniement.description;
    priceController.text = dbAccompaniement.price.toString();

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
                MenuAccompaniement updatedPerson = MenuAccompaniement(
                  name: nameController.text,
                  description: descriptionController.text,
                  price: double.parse(priceController.text),
                );

                setState(() {
                  menuAccompaniementBox.putAt(index, updatedPerson);
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
                      MaterialPageRoute(
                          builder: (context) => FormAccompaniement()),
                    );
                  },
                ),
              ),
            ),
          ],
          backgroundColor: const Color(0xFF5E2D71),
          title: const Center(
              child: Text(
            'Accompaniements',
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
            itemCount: menuAccompaniementBox.length,
            itemBuilder: (context, index) {
              MenuAccompaniement dbAccompaniement =
                  menuAccompaniementBox.getAt(index);
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
                            dbAccompaniement.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${dbAccompaniement.price.toString()} €',
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
                                            'Are you sure you want to delete ${dbAccompaniement.name}?'),
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
                                                menuAccompaniementBox
                                                    .deleteAt(index);
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
                        dbAccompaniement.description,
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
