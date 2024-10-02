import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' as platform_html; // Zamiast dart:html
import 'dart:io' as io; // dla platform mobilnych
import 'package:alvsell/Gadget.dart';
import 'package:path_provider/path_provider.dart'; // Dla Android/iOS
import 'package:open_file/open_file.dart'; // Dla Android/iOS

// Funkcja generująca PDF i otwierająca go w odpowiedni sposób dla Web i Mobile
Future<void> generateAndOpenPdf(List<Gadget> gadgets, String currentDate) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Raport sprzedaży - Data: $currentDate',
              style: pw.TextStyle(
                  fontSize: 24, fontWeight: pw.FontWeight.bold, font: pw.Font.helvetica()), // Wbudowana czcionka Helvetica
            ),
            pw.SizedBox(height: 16),
            pw.Text('Podsumowanie sprzedaży:', style: pw.TextStyle(fontSize: 18, font: pw.Font.helvetica())),
            pw.SizedBox(height: 8),
            pw.Text(
              'Zestawienie sprzedaży gadżetów:', 
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, font: pw.Font.helvetica()),
            ),
            pw.SizedBox(height: 8),
            ...gadgets.map((gadget) {
              double totalRevenueForGadget = gadget.totalRevenueCash + gadget.totalRevenueCard;
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    '${gadget.name}:',
                    style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: pw.Font.helvetica()),
                  ),
                  pw.Text(
                    'Sprzedaż gotówka: ${gadget.soldCash} szt., Karta: ${gadget.soldCard} szt.',
                    style: pw.TextStyle(fontSize: 10, font: pw.Font.helvetica()),
                  ),
                  pw.Text(
                    'Zarobek gotówka: ${gadget.totalRevenueCash.toStringAsFixed(2)} PLN, Zarobek karta: ${gadget.totalRevenueCard.toStringAsFixed(2)} PLN',
                    style: pw.TextStyle(fontSize: 10, font: pw.Font.helvetica()),
                  ),
                  pw.Text(
                    'Całkowity zarobek: ${totalRevenueForGadget.toStringAsFixed(2)} PLN',
                    style: pw.TextStyle(fontSize: 10, font: pw.Font.helvetica()),
                  ),
                  pw.SizedBox(height: 6),
                ],
              );
            }),
            pw.SizedBox(height: 16),
            pw.Text(
              'Podsumowanie sprzedaży:',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, font: pw.Font.helvetica()),
            ),
            pw.SizedBox(height: 8),
            pw.Text(
              'Suma sprzedaży za gotówkę: ${gadgets.fold(0.0, (sum, gadget) => sum + gadget.totalRevenueCash).toStringAsFixed(2)} PLN',
              style: pw.TextStyle(fontSize: 14, font: pw.Font.helvetica()),
            ),
            pw.Text(
              'Suma sprzedaży za kartę: ${gadgets.fold(0.0, (sum, gadget) => sum + gadget.totalRevenueCard).toStringAsFixed(2)} PLN',
              style: pw.TextStyle(fontSize: 14, font: pw.Font.helvetica()),
            ),
            pw.Text(
              'Całkowity zarobek: ${gadgets.fold(0.0, (sum, gadget) => sum + gadget.totalRevenue).toStringAsFixed(2)} PLN',
              style: pw.TextStyle(fontSize: 14, font: pw.Font.helvetica()),
            ),
          ],
        );
      },
    ),
  );

  final bytes = await pdf.save();

  if (kIsWeb) {
    // Dla przeglądarek webowych
    final blob = platform_html.Blob([bytes], 'application/pdf');
    final url = platform_html.Url.createObjectUrlFromBlob(blob);
    platform_html.window.open(url, '_blank');
    platform_html.Url.revokeObjectUrl(url);
  } else {
    // Dla urządzeń mobilnych (Android/iOS)
    final directory = await getApplicationDocumentsDirectory();
    final file = io.File('${directory.path}/report_$currentDate.pdf');
    await file.writeAsBytes(bytes);
    OpenFile.open(file.path);
  }
}
