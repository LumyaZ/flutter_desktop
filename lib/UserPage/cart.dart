import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:menu_desktop/main.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    Hive.openBox('menucart');
    final cartBox = Hive.box('menucart');
    var mealsInPanier = cartBox.values.toList();

    void removeItem(int index) {
      cartBox.deleteAt(index);
    }

    void refreshList() {
      setState(() {
        mealsInPanier = cartBox.values.toList();
      });
    }

    void validerCommande() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Commande validée'),
            content: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Votre commande est confirmée.'),
                SizedBox(height: 16),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.only(
            top: 16), // Définissez la valeur d'espace souhaitée
        child: ListView.builder(
          itemCount: mealsInPanier.length,
          itemBuilder: (context, index) {
            final dbmeal = mealsInPanier[index];

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
                                            removeItem(index);
                                            Navigator.of(context).pop(false);
                                            refreshList();
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
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          child: ElevatedButton(
            onPressed: validerCommande,
            child: const Text('Confirm the order'),
          ),
        ),
      ),
    );
  }
}
