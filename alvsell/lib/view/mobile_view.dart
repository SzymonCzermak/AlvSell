import 'dart:async';
import 'package:flutter/material.dart';
import 'package:alvsell/Gadget.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  List<Gadget> gadgets = [
    // Lista gadżetów
  ];

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
      backgroundColor: const Color.fromARGB(219, 0, 0, 0), // Ciemne tło
      appBar: AppBar(
        title: const Text('Sprzedaż Gadżetów - Mobile'),
        backgroundColor: const Color.fromARGB(255, 48, 48, 48), // Ciemny AppBar
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: gadgets.length,
        itemBuilder: (context, index) {
          final gadget = gadgets[index];
          return Container(
            margin: const EdgeInsets.all(8.0),
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
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Zdjęcie gadżetu po lewej
                  Image.asset(gadget.imagePath, width: 80, height: 80), // Większe zdjęcie na mobilnej wersji
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
                                      Icon(Icons.add, size: 14), // Ikona plusa dla "Gotówka"
                                      SizedBox(width: 4),
                                      Text('Gotówka', style: TextStyle(fontSize: 12)),
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
                                      Text('C. Gotówka', style: TextStyle(fontSize: 10)),
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
                                      Icon(Icons.add, size: 14), // Ikona plusa dla "Karta"
                                      SizedBox(width: 4),
                                      Text('Karta', style: TextStyle(fontSize: 12)),
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
                                      Text('C. Karta', style: TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

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
    );
  }
}
