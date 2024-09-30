import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sprzedaż Gadżetów',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sprzedaż Gadżetów'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Lista gadżetów
  List<Gadget> gadgets = [
    Gadget(name: 'Magnes wejście', price: 10.0),
    Gadget(name: 'Magnes kopuły pionowy', price: 10.0),
    Gadget(name: 'Magnes kopuły poziomy', price: 10.0),
    Gadget(name: 'Długopis', price: 8.0),
    Gadget(name: 'Butelka Jasna', price: 25.0),
    Gadget(name: 'Butelka Ciemna', price: 25.0),
    Gadget(name: 'Smycz', price: 6.0),
    Gadget(name: 'Zdjęcie', price: 20.0),
  ];

  // Zliczanie całkowitego dochodu
  double get totalRevenueCash {
    return gadgets.fold(0.0, (sum, gadget) => sum + gadget.totalRevenueCash);
  }

  double get totalRevenueCard {
    return gadgets.fold(0.0, (sum, gadget) => sum + gadget.totalRevenueCard);
  }

  double get totalRevenue {
    return totalRevenueCash + totalRevenueCard;
  }

  // Funkcje sprzedawania gadżetów
  void sellGadgetCash(Gadget gadget) {
    setState(() {
      gadget.sellCash();
    });
  }

  void sellGadgetCard(Gadget gadget) {
    setState(() {
      gadget.sellCard();
    });
  }

  // Funkcje cofania sprzedaży gadżetów
  void undoSellGadgetCash(Gadget gadget) {
    setState(() {
      gadget.undoSellCash();
    });
  }

  void undoSellGadgetCard(Gadget gadget) {
    setState(() {
      gadget.undoSellCard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // Lista przycisków reprezentujących gadżety
          Expanded(
  child: ListView.builder(
    itemCount: gadgets.length,
    itemBuilder: (context, index) {
      final gadget = gadgets[index];
      return ListTile(
        title: Text('${gadget.name} - Cena: ${gadget.price} PLN'),
        subtitle: Text('Sprzedano:\n ${gadget.soldCash} za gotówkę\n ${gadget.soldCard} za kartę'),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pierwszy rząd: Sprzedaż za gotówkę i kartę
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () => sellGadgetCash(gadget),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Zmniejszenie wysokości
                    minimumSize: Size(80, 25), // Minimalna wysokość przycisków
                  ),
                  child: Text('Sprzedaj 1 za gotówkę'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => sellGadgetCard(gadget),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Zmniejszenie wysokości
                    minimumSize: Size(80, 25), // Minimalna wysokość przycisków
                  ),
                  child: Text('Sprzedaj 1 za kartę'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Drugi rząd: Cofnij sprzedaż za gotówkę i kartę
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () => undoSellGadgetCash(gadget),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Zmniejszenie wysokości
                    minimumSize: Size(80, 25), // Minimalna wysokość przycisków
                  ),
                  child: Text('Cofnij 1 za gotówkę'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => undoSellGadgetCard(gadget),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Zmniejszenie wysokości
                    minimumSize: Size(80, 25), // Minimalna wysokość przycisków
                  ),
                  child: Text('Cofnij 1 za kartę'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  ),
),




          // Sekcja podsumowania
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Suma sprzedaży za gotówkę: ${totalRevenueCash.toStringAsFixed(2)} PLN',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Suma sprzedaży za kartę: ${totalRevenueCard.toStringAsFixed(2)} PLN',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Całkowity zarobek: ${totalRevenue.toStringAsFixed(2)} PLN',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Model danych dla gadżetu
class Gadget {
  String name;
  double price;
  int soldCash = 0;
  int soldCard = 0;

  Gadget({required this.name, required this.price});

  void sellCash() {
    soldCash += 1;
  }

  void sellCard() {
    soldCard += 1;
  }

  void undoSellCash() {
    if (soldCash > 0) {
      soldCash -= 1;
    }
  }

  void undoSellCard() {
    if (soldCard > 0) {
      soldCard -= 1;
    }
  }

  double get totalRevenueCash => soldCash * price;
  double get totalRevenueCard => soldCard * price;
}
