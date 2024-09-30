class Gadget {
  String name;
  double price;
  int soldCash = 0;
  int soldCard = 0;
  String imagePath; 

  Gadget({required this.name, required this.price, required this.imagePath});

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
