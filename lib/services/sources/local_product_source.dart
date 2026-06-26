import 'dart:convert';
import 'package:flutter/services.dart';
import '../../models/product.dart';
import 'product_source.dart';

class LocalProductSource implements ProductSource {
  @override
  Future<List<Product>> loadProducts() async {
    final jsonString =
        await rootBundle.loadString('assets/products.json');

    final Map<String, dynamic> data = json.decode(jsonString);

    final List productsJson = data['products'];

    return productsJson
        .map((json) => Product.fromJson(json))
        .toList();
  }
}