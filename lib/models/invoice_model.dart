class Invoice {
  final String client;
  final List<InvoiceItem> items;
  final double tax;
  final DateTime date;

  Invoice({
    required this.client,
    required this.items,
    required this.tax,
    required this.date,
  });

  double get total {
    double total = 0;
    for (final item in items) {
      total += item.price * item.quantity;
    }
    return total + tax;
  }
}

class InvoiceItem {
  String description = '';
  int quantity = 1;
  double price = 0.0;

  InvoiceItem();
}
