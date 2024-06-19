import 'package:flutter/material.dart';
import 'package:invoice_app/screens/invoice_list.dart';

void main() {
  runApp(const InvoiceApp());
}

class InvoiceApp extends StatelessWidget {
  const InvoiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice App',
      debugShowCheckedModeBanner: false,
      home: InvoiceList(),
    );
  }
}
