import 'package:alvsell/Gadget.dart';
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
  // Lista gadżetów z przypisanymi obrazkami
  List<Gadget> gadgets = [
  Gadget(name: 'Magnes wejście', price: 10.0, imagePath: 'assets/gadzety/Magnes wejście.png'),
  Gadget(name: 'Magnes kopuły pionowy', price: 10.0, imagePath: 'assets/gadzety/Magnes kopuły pionowy.png'),
  Gadget(name: 'Magnes kopuły poziomy', price: 10.0, imagePath: 'assets/gadzety/Magnes kopuły poziomy.png'),
  Gadget(name: 'Długopis', price: 8.0, imagePath: 'assets/gadzety/Długopis.png'),
  Gadget(name: 'Butelka Czarna', price: 25.0, imagePath: 'assets/gadzety/Butelka Czarna.png'),
  Gadget(name: 'Butelka pomarańczowa', price: 25.0, imagePath: 'assets/gadzety/Butelka pomarańczowa.png'),
  Gadget(name: 'Smycz', price: 6.0, imagePath: 'assets/gadzety/Smycz.png'),
  Gadget(name: 'Zdjęcie', price: 20.0, imagePath: 'assets/gadzety/Zdjęcie.png'),
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
      body: Column(
        children: [
          // Lista przycisków reprezentujących gadżety w dwóch kolumnach
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Dwie kolumny
                crossAxisSpacing: 8.0, // Odstęp poziomy między kolumnami
                mainAxisSpacing: 8.0, // Odstęp pionowy między wierszami
                childAspectRatio: 3,  // Kontrolowanie proporcji (szerokość/wysokość)
              ),
              itemCount: gadgets.length,
              itemBuilder: (context, index) {
                final gadget = gadgets[index];
                return Container(
  width: 150,  // Szerokość kafelka
  height: 200, // Wysokość kafelka
  decoration: BoxDecoration(
    color: const Color.fromARGB(170, 133, 133, 133),
    borderRadius: BorderRadius.circular(10),
    border: Border.all( // Dodanie czarnej ramki
      color: Colors.black, // Czarny kolor ramki
      width: 2.0, // Grubość ramki
    ),
    boxShadow: [
      BoxShadow(
        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 10,
        offset: Offset(0, 3), // Cień
      ), 
    ],
  ),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        // Dodanie obrazka po lewej stronie
        Image.asset(
          gadget.imagePath,
          width: 150, // Szerokość obrazka
          height: 150, // Wysokość obrazka
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Nazwa gadżetu
              Text(
                '${gadget.name}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Cena: ${gadget.price} PLN',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              // Sprzedaż za gotówkę i kartę - pierwszy rząd przycisków
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => sellGadgetCash(gadget),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      minimumSize: Size(60, 30), // Minimalna szerokość i wysokość przycisku
                      fixedSize: Size(120, 40),  // Dokładna szerokość i wysokość przycisku
                      backgroundColor: const Color.fromARGB(215, 76, 175, 79), // Kolor tła przycisku
                      foregroundColor: Colors.white, // Kolor tekstu przycisku
                      side: BorderSide(color: Colors.black, width: 2.0), // Czarna ramka o szerokości 2 piksele
                    ),
                    child: Text(
                      'Gotówka',
                      style: TextStyle(
                        fontSize: 14, // Rozmiar tekstu
                        color: Colors.white, // Kolor tekstu
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () => sellGadgetCard(gadget),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      minimumSize: Size(60, 30), // Minimalna szerokość i wysokość przycisku
                      fixedSize: Size(120, 40),  // Dokładna szerokość i wysokość przycisku
                      backgroundColor: const Color.fromARGB(207, 33, 149, 243), // Kolor tła przycisku
                      foregroundColor: Colors.white, // Kolor tekstu przycisku
                      side: BorderSide(color: Colors.black, width: 2.0), // Czarna ramka o szerokości 2 piksele
                    ),
                    child: Text(
                      'Karta',
                      style: TextStyle(
                        fontSize: 14, // Rozmiar tekstu
                        color: Colors.white, // Kolor tekstu
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 4),
              // Cofnij sprzedaż - drugi rząd przycisków
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => undoSellGadgetCash(gadget),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      minimumSize: Size(60, 30), // Minimalna szerokość i wysokość przycisku
                      fixedSize: Size(120, 20), // Dokładna szerokość i wysokość przycisku
                      backgroundColor: Colors.red, // Kolor tła przycisku
                      foregroundColor: Colors.white, // Kolor tekstu przycisku
                    ),
                    child: Text(
                      'Cofnij Gotówka',
                      style: TextStyle(
                        fontSize: 14, // Rozmiar tekstu
                        color: Colors.white, // Kolor tekstu
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () => undoSellGadgetCard(gadget),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      minimumSize: Size(60, 30), // Minimalna szerokość i wysokość przycisku
                      fixedSize: Size(120, 20), // Dokładna szerokość i wysokość przycisku
                      backgroundColor: const Color.fromARGB(206, 244, 67, 54), // Kolor tła przycisku
                      foregroundColor: Colors.white, // Kolor tekstu przycisku
                    ),
                    child: Text(
                      'Cofnij Karta',
                      style: TextStyle(
                        fontSize: 14, // Rozmiar tekstu
                        color: Colors.white, // Kolor tekstu
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Informacja o sprzedaży
              Text(
                'Gotówka: ${gadget.soldCash}, Karta: ${gadget.soldCard}',
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    ),
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
