import 'package:flutter/material.dart';
import 'package:invoice_app/models/invoice_model.dart';
import 'package:invoice_app/widgets/invoice_item_widget.dart';
import 'package:overlay_support/overlay_support.dart';

class InvoiceForm extends StatefulWidget {
  final Function(Invoice) onInvoiceAdded;

  const InvoiceForm({Key? key, required this.onInvoiceAdded}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InvoiceFormState createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceForm> {
  final _formKey = GlobalKey<FormState>();
  final client = TextEditingController();
  final items = <InvoiceItem>[];
  double tax = 0.0;

  void _addItem() {
    setState(() {
      items.add(InvoiceItem(description: '', price: 0.00, quantity: 1));
    });
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void _saveInvoice() {
    if (_formKey.currentState!.validate()) {
      final invoice = Invoice(
        client: client.text,
        items: items,
        date: DateTime.now(),
      );
      widget.onInvoiceAdded(invoice);

      // Show success message
      showSimpleNotification(const Text("Invoice added successfully"),
          background: Colors.green);
      Navigator.pop(context);
    } else {
      // Show error message
      showSimpleNotification(const Text("An error occured while saving"),
          background: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Invoice'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(56.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Client Name',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
                controller: client,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a client name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: _addItem,
                  child: const Text('Add an Item +'),
                ),
              ),
              const SizedBox(height: 6.0),
              Flexible(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return InvoiceItemWidget(
                      item: items[index],
                      onRemove: () => _removeItem(index),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveInvoice,
                child: const Text('Create Invoice'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
