class Gadget {
  String name;
  double price;
  int soldCash = 0;
  int soldCard = 0;
  String imagePath; 

  Gadget({required this.name, required this.price, required this.imagePath});

  // Funkcja do sprzedawania gadżetu za gotówkę
  void sellCash() {
    soldCash += 1;
  }

  // Funkcja do sprzedawania gadżetu za kartę
  void sellCard() {
    soldCard += 1;
  }

  // Cofanie sprzedaży za gotówkę
  void undoSellCash() {
    if (soldCash > 0) {
      soldCash -= 1;
    }
  }

  // Cofanie sprzedaży za kartę
  void undoSellCard() {
    if (soldCard > 0) {
      soldCard -= 1;
    }
  }

  // Obliczanie całkowitego dochodu z gotówki
  double get totalRevenueCash => soldCash * price;

  // Obliczanie całkowitego dochodu z kart
  double get totalRevenueCard => soldCard * price;

  // Funkcja do resetowania sprzedaży
  void resetSales() {
    soldCash = 0;
    soldCard = 0;
  }
  
  // Funkcja do obliczenia całkowitego dochodu (gotówka + karta)
  double get totalRevenue => totalRevenueCash + totalRevenueCard;
}
