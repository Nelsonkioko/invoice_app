import 'package:flutter/material.dart';
import '/models/invoice_model.dart';

class InvoiceItemWidget extends StatefulWidget {
  final InvoiceItem item;
  final VoidCallback onRemove;

  const InvoiceItemWidget({
    Key? key,
    required this.item,
    required this.onRemove,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InvoiceItemWidgetState createState() => _InvoiceItemWidgetState();
}

class _InvoiceItemWidgetState extends State<InvoiceItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: widget.item.description,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              onChanged: (value) {
                widget.item.description = value;
              },
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: widget.item.quantity.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      widget.item.quantity = int.parse(value);
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    initialValue: widget.item.price.toStringAsFixed(2),
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      widget.item.price = double.parse(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: widget.onRemove,
                  child: const Text('Remove'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
