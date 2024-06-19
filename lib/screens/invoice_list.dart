import 'package:flutter/material.dart';
import 'package:invoice_app/forms/invoice_form.dart';
import 'package:invoice_app/models/invoice_model.dart';
import 'invoice_details_screen.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InvoiceListState createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  final List<Invoice> _invoices = [
    Invoice(
      client: 'Nelson Kioko',
      items: [
        InvoiceItem()
          ..description = 'Item 1'
          ..quantity = 2
          ..price = 10.0,
        InvoiceItem()
          ..description = 'Item 2'
          ..quantity = 1
          ..price = 20.0,
      ],
      tax: 2.5,
      date: DateTime.now(),
    ),
    Invoice(
      client: 'Eric Client',
      items: [
        InvoiceItem()
          ..description = 'Item 1'
          ..quantity = 5
          ..price = 10.0,
        InvoiceItem()
          ..description = 'Item 2'
          ..quantity = 1
          ..price = 20.0,
      ],
      tax: 2.5,
      date: DateTime.now(),
    ),
    Invoice(
      client: 'Raymond client',
      items: [
        InvoiceItem()
          ..description = 'Item A'
          ..quantity = 3
          ..price = 5.0,
        InvoiceItem()
          ..description = 'Item B'
          ..quantity = 1
          ..price = 15.0,
      ],
      tax: 1.0,
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InvoiceForm(
                          invoices: _invoices,
                          onInvoiceAdded: (invoice) {},
                        )),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _invoices.length,
        itemBuilder: (context, index) {
          final invoice = _invoices[index];
          return Padding(
            padding: const EdgeInsets.only(top: 20, right: 78.0, left: 78.0),
            child: Card(
              child: ListTile(
                title: Text(invoice.client),
                subtitle: Text(
                    '${invoice.date} - KES ${invoice.total.toStringAsFixed(2)}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InvoiceDetails(invoice: invoice)),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
