import 'dart:async';
import 'package:alvsell/pdf_raport.dart';
import 'package:flutter/material.dart';
import 'package:alvsell/Gadget.dart';

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
    Gadget(name: 'Kawa', price: 8.0, imagePath: 'assets/gadzety/Kawa.png'),
  ];

  // Zmienne dla czasu i timera
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _startClock(); // Uruchomienie zegara przy starcie aplikacji
  }

  void _startClock() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _formatCurrentTime();
      });
    });
  }

  String _formatCurrentDate() {
    DateTime now = DateTime.now();
    return "${now.day}-${now.month}-${now.year}";
  }

  String _formatCurrentTime() {
    DateTime now = DateTime.now();
    return "${now.hour}:${now.minute}:${now.second}";
  }

  // Funkcja resetująca wszystkie wartości sprzedaży
  void resetAll() {
    setState(() {
      for (var gadget in gadgets) {
        gadget.resetSales();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(219, 0, 0, 0),
      body: Column(
        children: [
          // Sekcja z godziną bez tła z obrazka, z własnym kolorem
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Data: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 240, 128, 0), // Kolor dla słowa "Data"
                      ),
                    ),
                    TextSpan(
                      text: '${_formatCurrentDate()}  ', // Aktualna data
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 255, 255), // Kolor dla aktualnej daty
                      ),
                    ),
                    TextSpan(
                      text: 'Czas: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 240, 128, 0),
                      ),
                    ),
                    TextSpan(
                      text: _formatCurrentTime(), // Aktualny czas
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 255, 255), // Kolor dla aktualnego czasu
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Sekcja GridView z obrazem tła
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/TłoAlvSell.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 2.7,
                ),
                itemCount: gadgets.length,
                itemBuilder: (context, index) {
                  final gadget = gadgets[index];
                  return Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(135, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            gadget.imagePath,
                            width: 150,
                            height: 150,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  gadget.name,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Cena: ${gadget.price} PLN',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => setState(() => gadget.sellCash()),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        fixedSize: const Size(120, 40),
                                        backgroundColor: const Color.fromARGB(181, 0, 194, 6),
                                        foregroundColor: Colors.white,
                                        side: const BorderSide(color: Colors.black, width: 1.5),
                                      ),
                                      child: const Text(
                                        'Gotówka',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    ElevatedButton(
                                      onPressed: () => setState(() => gadget.sellCard()),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        fixedSize: const Size(120, 40),
                                        backgroundColor: const Color.fromARGB(192, 0, 140, 255),
                                        foregroundColor: Colors.white,
                                        side: const BorderSide(color: Colors.black, width: 1.5),
                                      ),
                                      child: const Text(
                                        'Karta',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => setState(() => gadget.undoSellCash()),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                        fixedSize: const Size(100, 5),
                                        backgroundColor: const Color.fromARGB(150, 255, 17, 0),
                                        foregroundColor: Colors.white,
                                        side: const BorderSide(color: Colors.black, width: 1.0),
                                      ),
                                      child: const Text(
                                        'Cofnij Gotówka',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () => setState(() => gadget.undoSellCard()),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        fixedSize: const Size(100, 5),
                                        backgroundColor: const Color.fromARGB(150, 255, 17, 0),
                                        foregroundColor: Colors.white,
                                        side: const BorderSide(color: Colors.black, width: 1.0),
                                      ),
                                      child: const Text(
                                        'Cofnij Karta',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Gotówka: ${gadget.soldCash}, Karta: ${gadget.soldCard}',
                                  style: const TextStyle(fontSize: 14),
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
          ),

          // Sekcja podsumowania z innym kolorem, bez tła z obrazka
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Suma sprzedaży za gotówkę: ${gadgets.fold(0.0, (sum, gadget) => sum + gadget.totalRevenueCash).toStringAsFixed(2)} PLN',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Suma sprzedaży za kartę: ${gadgets.fold(0.0, (sum, gadget) => sum + gadget.totalRevenueCard).toStringAsFixed(2)} PLN',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        'Całkowity zarobek: ${gadgets.fold(0.0, (sum, gadget) => sum + gadget.totalRevenue).toStringAsFixed(2)} PLN',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: resetAll,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(187, 244, 67, 54),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  child: const Text('Resetuj'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => generateAndOpenPdf(gadgets, _formatCurrentDate()), // Wywołanie funkcji generującej PDF
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(187, 0, 149, 255),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  child: const Text('Generuj PDF'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
