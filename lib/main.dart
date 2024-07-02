import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:invoice_app/models/invoice_model.dart';
import 'package:invoice_app/repository/invoice_repository.dart';
import 'package:invoice_app/screens/invoice_list.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(InvoiceAdapter());
  Hive.registerAdapter(InvoiceItemAdapter());
  await Hive.openBox<Invoice>('invoices');
  // Pre-load data from JSON
  await InvoiceDataManager.preloadDataFromJson();

  runApp(const OverlaySupport.global(child: InvoiceApp()));
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
