import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:menu_desktop/UserPage/cart.dart';
import 'package:menu_desktop/UserPage/navUser.dart';
import 'package:menu_desktop/box.dart';
import 'package:menu_desktop/menu_desktop_db.dart';

class AccompaniementUser extends StatefulWidget {
  Future<void> openBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MenuAccompaniementAdapter());
    menuAccompaniementBox =
        await Hive.openBox<MenuAccompaniement>('menuaccompaniement');
  }

  @override
  _AccompaniementUserState createState() => _AccompaniementUserState();
}

class _AccompaniementUserState extends State<AccompaniementUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarUser(),
      appBar: AppBar(
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cart()),
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
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            final cartBox = Hive.box('menucart');
                            cartBox.add(dbAccompaniement);
                          },
                          child: const Text('Add to cart'),
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
