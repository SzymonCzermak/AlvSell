import 'package:alvsell/view/web_view.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'view/mobile_view.dart';  // Importuj widok przeglądarki
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
      home: kIsWeb ? const WebHomePage() : const MobileHomePage(),
    );
  }
}
