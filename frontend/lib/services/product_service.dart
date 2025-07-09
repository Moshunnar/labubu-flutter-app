import '../models/product.dart';

class ProductService {
  static List<Product> getAllProducts() {
    return [
      Product(
        id: 'labubu_1',
        name: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll',
        price: 199.99,
        oldPrice: 220.00,
        image: 'assets/images/tq_1bly61chv1-ahz-400h.png',
        description: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll with signature charm and collectible quality.',
      ),
      Product(
        id: 'labubu_2',
        name: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll',
        price: 199.99,
        oldPrice: 220.00,
        image: 'assets/images/tq_gmaoc6n3jd-pq1-400h.png',
        description: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll perfect for any collection.',
      ),
      Product(
        id: 'labubu_4',
        name: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll',
        price: 199.99,
        oldPrice: 220.00,
        image: 'assets/images/tq_jkuejch7pg-7oih-400h.png',
        description: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll with nature-inspired charm.',
      ),
      Product(
        id: 'labubu_5',
        name: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll',
        price: 199.99,
        oldPrice: 220.00,
        image: 'assets/images/product 5.png',
        description: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll with mystical appeal.',
      ),
      Product(
        id: 'labubu_7',
        name: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll',
        price: 199.99,
        oldPrice: 220.00,
        image: 'assets/images/tq_nz_vrotlrr-t63a-400h.png',
        description: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll with ocean-inspired charm.',
      ),
      Product(
        id: 'labubu_6',
        name: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll',
        price: 199.99,
        oldPrice: 220.00,
        image: 'assets/images/product 6.png',
        description: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll with unique design.',
      ),
      Product(
        id: 'labubu_8',
        name: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll',
        price: 199.99,
        oldPrice: 220.00,
        image: 'assets/images/product 7.png',
        description: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll with special features.',
      ),
      Product(
        id: 'labubu_9',
        name: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll',
        price: 199.99,
        oldPrice: 220.00,
        image: 'assets/images/product 8.png',
        description: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll with premium quality.',
      ),
    ];
  }

  static Product? getProductById(String id) {
    try {
      return getAllProducts().firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<Product> getFeaturedProducts() {
    return getAllProducts().take(6).toList();
  }

  static List<Product> getOnSaleProducts() {
    return getAllProducts().where((product) => product.oldPrice != null).toList();
  }
}
