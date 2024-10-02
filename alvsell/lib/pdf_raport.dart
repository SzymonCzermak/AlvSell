import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;
import 'package:alvsell/Gadget.dart'; 

// Funkcja generująca PDF i otwierająca go w nowej karcie
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

  // Konwersja dokumentu PDF do listy bajtów
  final bytes = await pdf.save();

  // Tworzenie Blob z danych PDF
  final blob = html.Blob([bytes], 'application/pdf');
  
  // Utwórz URL do Blob i otwórz go w nowej karcie
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.window.open(url, '_blank');

  // Opcjonalnie: Zwolnij URL Blob po zakończeniu
  html.Url.revokeObjectUrl(url);
}
