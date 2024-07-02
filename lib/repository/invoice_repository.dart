import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';

import '../models/invoice_model.dart';

class InvoiceDataManager {
  static const String _hiveBoxName = 'invoices';

  // Method to preload initial data from JSON file into Hive
  static Future<void> preloadDataFromJson() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/invoices.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);

      final Box<Invoice> invoiceBox = await Hive.openBox<Invoice>(_hiveBoxName);

      await invoiceBox.clear(); // Clear existing data

      for (var invoiceJson in jsonData) {
        final invoice = Invoice.fromJson(invoiceJson);
        await invoiceBox.add(invoice);
      }
    } catch (e) {
      //print('Error preloading data from JSON: $e');
      showSimpleNotification(Text("Error loading invoices: $e"),
          background: Colors.red);
    }
  }

  // Method to load invoices from Hive storage
  static Future<List<Invoice>> loadInvoices() async {
    try {
      final Box<Invoice> invoiceBox = await Hive.openBox<Invoice>(_hiveBoxName);
      return invoiceBox.values.toList();
    } catch (e) {
      // print('Error loading invoices from Hive: $e');
      showSimpleNotification(Text("Error loading invoices: $e"),
          background: Colors.red);
      return [];
    }
  }

  // Method to save invoices to Hive storage
  static Future<void> saveInvoices(List<Invoice> invoices) async {
    try {
      final Box<Invoice> invoiceBox = await Hive.openBox<Invoice>(_hiveBoxName);
      await invoiceBox.clear(); // Clear existing data
      await invoiceBox.addAll(invoices); // Add updated data
    } catch (e) {
      //print('Error saving invoices to Hive: $e');
      showSimpleNotification(Text("Error loading invoices: $e"),
          background: Colors.red);
    }
  }
}
