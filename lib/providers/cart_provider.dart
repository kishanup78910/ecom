import 'package:flutter/material.dart';

class Product {
  String name;
  double price;
  int qty = 1;
  int qntty;
  List imagesUrl;
  String documentId;
  String suppId;
  Product({
    required this.name,
    required this.price,
    required this.qty,
    required this.qntty,
    required this.imagesUrl,
    required this.documentId,
    required this.suppId,
  });
}

class cart extends ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getItems {
    return _list;
  }
}
