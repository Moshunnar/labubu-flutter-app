import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cart_model.dart';
import '../services/product_service.dart';
import 'product_detail_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String _selectedCategory = 'Blind Boxes';
  late List<Product> _allProducts;
  late List<Product> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _allProducts = _getAddOnProducts();
    // Filter products based on the default selection
    _filterProducts(_selectedCategory);
  }

  // Same add-on products as SearchCatalogScreen - exact matches from Figma
  List<Product> _getAddOnProducts() {
    return [
      Product(
        id: 'addon_1',
        name: 'THE MONSTERS Big into Energy Series-Vinyl Plush Pendant Blind Box (secret box)',
        price: 60.00,
        oldPrice: 120.00,
        image: 'assets/images/image31258-zg4-200h.png',
        description: 'Big into Energy Series pendant blind box',
      ),
      Product(
        id: 'addon_2',
        name: 'THE MONSTERS - ANGEL IN CLOUDS Vinyl Face Doll',
        price: 299.99,
        oldPrice: 320.00,
        image: 'assets/images/image38813-ogqi-200h.png',
        description: 'ANGEL IN CLOUDS vinyl face doll',
      ),
      Product(
        id: 'addon_3',
        name: 'THE MONSTERS - I FOUND YOU Vinyl Face Doll',
        price: 199.99,
        oldPrice: 220.00,
        image: 'assets/images/image38814-gjec-200h.png',
        description: 'I FOUND YOU vinyl face doll',
      ),
      Product(
        id: 'addon_4',
        name: 'THE MONSTERS Let\'s Checkmate Series-Vinyl Plush Doll',
        price: 114.99,
        oldPrice: 234.00,
        image: 'assets/images/image38814-0fpa-200h.png',
        description: 'Let\'s Checkmate Series vinyl plush doll',
      ),
    ];
  }

  void _filterProducts(String category) {
    setState(() {
      _selectedCategory = category;
      // Always show all products regardless of category selection
      _filteredProducts = _allProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 50), // Adjusted for status bar
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),                // Header with navigation
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    // Profile icon (fixed width)
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF62528),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    
                    // Logo and title (centered and flexible)
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/popartlogo8113-eu4u-200h.png',
                            height: 25,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.star, color: Color(0xFFF52428));
                            },
                          ),
                          const Text(
                            'LABuBu',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFC300),
                              fontFamily: 'CherryBombOne',
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Cart icon (fixed width container to prevent shift)
                    Container(
                      width: 60, // Reduced from 70 to make it more compact
                      height: 42,
                      child: Consumer<CartModel>(
                        builder: (context, cart, child) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Close catalog
                              Navigator.pushNamed(context, '/cart');
                            },
                            child: Container(
                              width: cart.itemCount > 0 ? 58 : 42, // More compact sizing
                              height: 42,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF62528),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: cart.itemCount > 0 
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Image.asset(
                                          'assets/images/shopping-cart.png',
                                          width: 24,
                                          height: 24,
                                          color: Colors.white,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(width: 2), // Reduced spacing
                                      Text(
                                        '${cart.itemCount}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Image.asset(
                                      'assets/images/shopping-cart.png',
                                      width: 24,
                                      height: 24,
                                      color: Colors.white,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              
              // "Catalog" title
              const Text(
                'Catalog',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF313131),
                  fontSize: 17,
                  fontFamily: 'Belanosima',
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Character filter section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(child: _buildCategoryFilter('MONSTERS', 'assets/images/image38814-gjec-200h.png')),
                    Expanded(child: _buildCategoryFilter('LABUBU', 'assets/images/image28813-jzhv-200h.png')),
                    Expanded(child: _buildCategoryFilter('CRYBABY', 'assets/images/image28813-kr9-200h.png')),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Product grid
              Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF52428),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(42),
                  topRight: Radius.circular(42),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  
                  // Search bar (moved to red area)
                  Container(
                    height: 48,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[300]!, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search for your Labubu name..',
                              hintStyle: TextStyle(
                                color: Color(0xFF878787),
                                fontSize: 15,
                                fontFamily: 'Segoe UI',
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: TextStyle(
                              color: Color(0xFF313131),
                              fontSize: 15,
                              fontFamily: 'Segoe UI',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/search-normal.svg',
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 15),
                  
                  // Category filter chips (in red area)
                  Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip('Blind Boxes'),
                          const SizedBox(width: 10),
                          _buildFilterChip('Accessories'),
                          const SizedBox(width: 10),
                          _buildFilterChip('Bags'),
                          const SizedBox(width: 10),
                          _buildFilterChip('Fridge Management'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        return _buildProductItem(product);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
            ],
          ),
          
          // Status image - positioned at bottom right - clickable to go to ProductDetailScreen
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Navigate to ProductDetailScreen with MAIN product (not catalog products)
                final mainProducts = ProductService.getAllProducts();
                final defaultProduct = mainProducts.isNotEmpty ? mainProducts.first : Product(
                  id: 'default',
                  name: 'Default Product',
                  price: 0.0,
                  image: '',
                  description: 'Default',
                );
                // Custom fade transition back to ProductDetailScreen
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 600),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ProductDetailScreen(product: defaultProduct),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/status.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Color(0xFFF52428),
                        size: 24,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(String name, String imagePath) {
    final isSelected = _selectedCategory == name;
    return GestureDetector(
      onTap: () => _filterProducts(name),
      child: Container(
        width: 71,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: isSelected 
                        ? const Color(0xFFF52428) 
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'Segoe UI',
                fontWeight: FontWeight.w300,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () => _filterProducts(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFFF52428) : Colors.white,
            fontSize: 15,
            fontFamily: 'Segoe UI',
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildProductItem(Product product) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        final quantity = cart.getQuantity(product.id);
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              Container(
                width: 115,
                height: 115,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      product.image,
                      width: 115,
                      height: 115,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.image, color: Colors.grey),
                        );
                      },
                    ),
                    // Quantity controls - conditional display
                    Positioned(
                      bottom: 8,
                      left: quantity == 0 ? 43 : 13, // Fine-tune positioning: single + perfect, quantity row slightly left for breathing space
                      child: quantity == 0 
                        ? // Show only + button when quantity is 0
                          GestureDetector(
                            onTap: () {
                              cart.addItem(product);
                            },
                            child: Container(
                              width: 28, // Reduced from 32
                              height: 28, // Reduced from 32
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/images/addA.svg',
                                  width: 20, // Reduced from 24
                                  height: 20, // Reduced from 24
                                  colorFilter: const ColorFilter.mode(
                                    Color(0xFF323232),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : // Show - quantity + when quantity > 0
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Minus button
                              GestureDetector(
                                onTap: () {
                                  if (quantity > 1) {
                                    cart.updateQuantity(product.id, quantity - 1);
                                  } else if (cart.isInCart(product.id)) {
                                    cart.removeItem(product.id);
                                  }
                                },
                                child: Container(
                                  width: 28, // Reduced from 32
                                  height: 28, // Reduced from 32
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/images/minusAAA.svg',
                                      width: 20, // Reduced from 24
                                      height: 20, // Reduced from 24
                                      colorFilter: const ColorFilter.mode(
                                        Color(0xFF323232),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6), // Reduced from 8
                              // Quantity display
                              Container(
                                width: 28, // Reduced from 32
                                height: 28, // Reduced from 32
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    '$quantity',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 20, // Reduced from 24
                                      fontFamily: 'Segoe UI',
                                      fontWeight: FontWeight.w700,
                                      height: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6), // Reduced from 8
                              // Plus button
                              GestureDetector(
                                onTap: () {
                                  cart.addItem(product);
                                },
                                child: Container(
                                  width: 28, // Reduced from 32
                                  height: 28, // Reduced from 32
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/images/addA.svg',
                                      width: 20, // Reduced from 24
                                      height: 20, // Reduced from 24
                                      colorFilter: const ColorFilter.mode(
                                        Color(0xFF323232),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 18),
              
              // Product info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    Text(
                      product.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'Belanosima',
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 9),
                    
                    // Price
                    Row(
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)} usd',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Segoe UI',
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                        if (product.oldPrice != null) ...[
                          const SizedBox(width: 5),
                          Text(
                            '(\$${product.oldPrice!.toStringAsFixed(0)})',
                            style: const TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: 13,
                              fontFamily: 'Segoe UI',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.lineThrough,
                              height: 1,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
