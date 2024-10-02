// Definicja klasy Gadget
class Gadget {
  final String name;
  final double price;
  final String imagePath;
  int soldCash = 0;
  int soldCard = 0;
  double totalRevenueCash = 0;
  double totalRevenueCard = 0;

  Gadget({required this.name, required this.price, required this.imagePath});

  // Sprzedaż za gotówkę
  void sellCash() {
    soldCash += 1;
    totalRevenueCash += price;
  }

  // Sprzedaż za kartę
  void sellCard() {
    soldCard += 1;
    totalRevenueCard += price;
  }

  // Cofnięcie sprzedaży za gotówkę
  void undoSellCash() {
    if (soldCash > 0) {
      soldCash -= 1;
      totalRevenueCash -= price;
    }
  }

  // Cofnięcie sprzedaży za kartę
  void undoSellCard() {
    if (soldCard > 0) {
      soldCard -= 1;
      totalRevenueCard -= price;
    }
  }

  // Resetowanie sprzedaży
  void resetSales() {
    soldCash = 0;
    soldCard = 0;
    totalRevenueCash = 0;
    totalRevenueCard = 0;
  }

  // Całkowity zarobek
  double get totalRevenue => totalRevenueCash + totalRevenueCard;
}

// Lista gadżetów
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
