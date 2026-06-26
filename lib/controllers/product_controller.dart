import '../models/product.dart';
import '../services/sources/product_source.dart';

class ProductController {
  final ProductSource source;

  ProductController(this.source);

  Future<List<Product>> getProducts() {
    return source.loadProducts();
  }
}