import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:invoice_app/forms/invoice_form.dart';
import '../models/invoice_model.dart';
import 'invoice_details_screen.dart';

// ignore: use_key_in_widget_constructors
class InvoiceList extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _InvoiceListState createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  late Box<Invoice> invoiceBox;

  @override
  void initState() {
    super.initState();
    invoiceBox = Hive.box<Invoice>('invoices');
  }

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
                    onInvoiceAdded: (invoice) {
                      setState(() {
                        invoiceBox.add(invoice);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: invoiceBox.listenable(),
        builder: (context, Box<Invoice> box, _) {
          if (box.values.isEmpty) {
            return const Center(child: Text('No invoices added.'));
          }

          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              final invoice = box.getAt(index);
              return Padding(
                padding:
                    const EdgeInsets.only(top: 20, right: 78.0, left: 78.0),
                child: Card(
                  child: ListTile(
                    title: Text(invoice!.client),
                    subtitle: Text(
                      '${invoice.date} - KES ${invoice.total.toStringAsFixed(2)}',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              InvoiceDetails(invoice: invoice),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
