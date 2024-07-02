import 'package:hive/hive.dart';

part 'invoice_model.g.dart';

@HiveType(typeId: 0)
class Invoice extends HiveObject {
  @HiveField(0)
  final String client;

  @HiveField(1)
  final List<InvoiceItem> items;

  @HiveField(2)
  final DateTime date;

  Invoice({
    required this.client,
    required this.items,
    required this.date,
  });

  double get subtotal {
    double subtotal = 0;
    for (var item in items) {
      subtotal += item.price * item.quantity;
    }
    return subtotal;
  }

  double get tax {
    return subtotal * 0.2; // 20% tax
  }

  double get total {
    return subtotal + tax;
  }

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      client: json['client'],
      items: (json['items'] as List)
          .map((item) => InvoiceItem.fromJson(item))
          .toList(),
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client': client,
      'items': items.map((item) => item.toJson()).toList(),
      'date': date.toIso8601String(),
    };
  }
}

@HiveType(typeId: 1)
class InvoiceItem extends HiveObject {
  @HiveField(0)
  String description;

  @HiveField(1)
  int quantity;

  @HiveField(2)
  double price;

  InvoiceItem({
    required this.description,
    required this.quantity,
    required this.price,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      description: json['description'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'quantity': quantity,
      'price': price,
    };
  }
}
