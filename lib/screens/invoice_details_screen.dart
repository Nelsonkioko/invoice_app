import 'package:flutter/material.dart';
import '/models/invoice_model.dart';

class InvoiceDetails extends StatelessWidget {
  final Invoice invoice;

  const InvoiceDetails({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Client: ${invoice.client}'),
            const SizedBox(height: 8.0),
            Text('Date: ${invoice.date.toString()}'),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: invoice.items.length,
                itemBuilder: (context, index) {
                  final item = invoice.items[index];
                  return ListTile(
                    title: Text(item.description),
                    subtitle: Text(
                        'Quantity: ${item.quantity}, Price: KES ${item.price.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Text('Tax: KES ${invoice.tax.toStringAsFixed(2)}'),
            const SizedBox(height: 8.0),
            Text('Total: KES ${invoice.total.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
