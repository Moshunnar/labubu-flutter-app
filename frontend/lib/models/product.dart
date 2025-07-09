class Product {
  final String id;
  final String name;
  final double price;
  final double? oldPrice;
  final String image;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.oldPrice,
    required this.image,
    required this.description,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
}
