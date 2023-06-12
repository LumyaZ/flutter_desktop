import 'package:flutter/material.dart';
import 'package:menu_desktop/UserPage/accompaniementUser.dart';
import 'package:menu_desktop/UserPage/cart.dart';
import 'package:menu_desktop/UserPage/drinkUser.dart';
import 'package:menu_desktop/UserPage/mealUser.dart';
import 'package:menu_desktop/main.dart';

class NavBarUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF5E2D71),
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        children: [
          const SizedBox(height: 20),
          const Text(
            "ShapeMyMeal",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          ListTile(
            contentPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            title: const Text(
              'Meals',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MealUser()),
              );
            },
          ),
          const SizedBox(height: 30),
          ListTile(
            title: const Text(
              'Accompaniments',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccompaniementUser()),
              );
            },
          ),
          const SizedBox(height: 30),
          ListTile(
            title: const Text(
              'Drinks',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DrinkUser()),
              );
            },
          ),
          const SizedBox(height: 30),
          ListTile(
            title: const Text(
              'Cart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cart()),
              );
            },
          ),
          const SizedBox(height: 30),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirmation'),
                    content: const Text('Are you sure you want to disconnect?'),
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
            child: const Text('Disconnect'),
          ),
        ],
      ),
    );
  }
}
