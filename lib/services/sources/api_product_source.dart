import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/product.dart';
import 'product_source.dart';

class ApiProductSource implements ProductSource {
  @override
  Future<List<Product>> loadProducts() async {
    final url = Uri.parse('https://dummyjson.com/products?limit=0&select=id,title,price,thumbnail');

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Erreur API : ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    final List productsJson = data['products'];

    return productsJson.map((json) => Product.fromJson(json)).toList();
  }
}