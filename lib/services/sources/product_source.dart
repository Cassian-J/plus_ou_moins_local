import '../../models/product.dart';

abstract class ProductSource {
  Future<List<Product>> loadProducts();
}