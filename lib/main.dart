import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:menu_desktop/AdminPage/mealAdmin.dart';
import 'package:menu_desktop/UserPage/mealUser.dart';
import 'package:menu_desktop/box.dart';
import 'package:menu_desktop/menu_desktop_db.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(MenuMealAdapter());
  menuMealBox = await Hive.openBox<MenuMeal>('menumeal');

  Hive.registerAdapter(MenuAccompaniementAdapter());
  menuAccompaniementBox =
      await Hive.openBox<MenuAccompaniement>('menuaccompaniement');

  Hive.registerAdapter(MenuDrinkAdapter());
  menuDrinkBox = await Hive.openBox<MenuDrink>('menudrink');

  Hive.openBox('menucart');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page home',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 220, 227, 241),
        appBar: AppBar(
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
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
                      const Text(
                        'How do you want to connect?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MealAdmin()),
                              );
                            },
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 216, 186, 228)),
                            ),
                            child: const Text(
                              'Administrator',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 45, 45, 42)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MealUser()),
                              );
                            },
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 249, 250, 253)),
                            ),
                            child: const Text(
                              'User',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 45, 45, 42)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
