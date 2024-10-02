import 'dart:async';
import 'package:flutter/material.dart';
import 'package:alvsell/pdf_raport.dart';
import 'package:alvsell/Gadget.dart'; // Importujemy dane gadżetów i klasę Gadget

class WebHomePage extends StatefulWidget {
  const WebHomePage({super.key});

  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _startClock();
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
                        color: const Color.fromARGB(255, 240, 128, 0),
                      ),
                    ),
                    TextSpan(
                      text: '${_formatCurrentDate()}  ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 255, 255),
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
                      text: _formatCurrentTime(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Główna część z kafelkami
          Expanded(
            child: Center(
              child: Container(
                width: 800, // Maksymalna szerokość
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
                    childAspectRatio: 2, // Stały stosunek szerokości do wysokości
                  ),
                  itemCount: gadgets.length,
                  itemBuilder: (context, index) {
                    final gadget = gadgets[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(135, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2.5),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Zdjęcie gadżetu po lewej
                            Image.asset(gadget.imagePath, width: 90, height: 90),
                            const SizedBox(width: 8),

                            // Nazwa gadżetu, przyciski i sprzedane sztuki po prawej
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    gadget.name,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Cena: ${gadget.price} PLN',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(height: 8),

                                  // Przycisk "Gotówka" i "Cofnij Gotówka"
                                  Row(
                                    children: [
                                      Flexible(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: ElevatedButton(
                                            onPressed: () => setState(() => gadget.sellCash()),
                                            style: ElevatedButton.styleFrom(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                              backgroundColor: const Color.fromARGB(181, 0, 194, 6),
                                              foregroundColor: Colors.white,
                                              side: const BorderSide(color: Colors.black, width: 1.5),
                                            ),
                                            child: Row(
                                              children: const [
                                                Icon(Icons.add, size: 20), // Ikona plusa dla "Gotówka"
                                                SizedBox(width: 2),
                                                Text('Gotówka', style: TextStyle(fontSize: 18)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Flexible(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: ElevatedButton(
                                            onPressed: () => setState(() => gadget.undoSellCash()),
                                            style: ElevatedButton.styleFrom(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                              backgroundColor: const Color.fromARGB(150, 255, 17, 0),
                                              foregroundColor: Colors.white,
                                              side: const BorderSide(color: Colors.black, width: 1.5),
                                            ),
                                            child: Row(
                                              children: const [
                                                Icon(Icons.remove, size: 14), // Ikona minusa dla "Cofnij Gotówka"
                                                SizedBox(width: 4),
                                                Text('C. Gotówka', style: TextStyle(fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 6),

                                  // Przycisk "Karta" i "Cofnij Karta"
                                  Row(
                                    children: [
                                      Flexible(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: ElevatedButton(
                                            onPressed: () => setState(() => gadget.sellCard()),
                                            style: ElevatedButton.styleFrom(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                              backgroundColor: const Color.fromARGB(192, 0, 140, 255),
                                              foregroundColor: Colors.white,
                                              side: const BorderSide(color: Colors.black, width: 1.5),
                                            ),
                                            child: Row(
                                              children: const [
                                                Icon(Icons.add, size: 20), // Ikona plusa dla "Karta"
                                                SizedBox(width: 2),
                                                Text('Karta', style: TextStyle(fontSize: 18)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Flexible(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: ElevatedButton(
                                            onPressed: () => setState(() => gadget.undoSellCard()),
                                            style: ElevatedButton.styleFrom(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                              backgroundColor: const Color.fromARGB(150, 255, 17, 0),
                                              foregroundColor: Colors.white,
                                              side: const BorderSide(color: Colors.black, width: 1.5),
                                            ),
                                            child: Row(
                                              children: const [
                                                Icon(Icons.remove, size: 14), // Ikona minusa dla "Cofnij Karta"
                                                SizedBox(width: 4),
                                                Text('C. Karta', style: TextStyle(fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  // Wyświetlanie liczby sprzedanych sztuk poniżej przycisków, mniejszym drukiem
                                  Row(
                                    children: [
                                      Text(
                                        'Sprzedano (gotówka): ${gadget.soldCash}',
                                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 10), // Mniejszy odstęp
                                      Text(
                                        'Sprzedano (karta): ${gadget.soldCard}',
                                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                      ),
                                    ],
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
          ),

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
                  onPressed: () => generateAndOpenPdf(gadgets, _formatCurrentDate()),
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
