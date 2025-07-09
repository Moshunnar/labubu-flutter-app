import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cart_model.dart';
import '../services/product_service.dart';
import 'search_catalog_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late List<Product> _allProducts;
  String _selectedCharacter = 'MONSTERS'; // Add selected character state
  
  // Animation controllers for add to cart splash effect
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _allProducts = ProductService.getAllProducts();
    _currentIndex = _allProducts.indexWhere((p) => p.id == widget.product.id);
    
    // If product not found in main list (e.g., add-on products), DON'T add it
    // Just show the main products and set index to 0
    if (_currentIndex == -1) {
      _currentIndex = 0; // Default to first product in main list
    }
    
    // Initialize animation controller for add to cart effect
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Setup animations for splash effect
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.4,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
    ));
    
    // Set initial selected character based on current product
    if (_allProducts.isNotEmpty && _currentIndex >= 0) {
      final currentProduct = _allProducts[_currentIndex];
      if (currentProduct.name.toUpperCase().contains('LABUBU')) {
        _selectedCharacter = 'LABUBU';
      } else if (currentProduct.name.toUpperCase().contains('CRYBABY')) {
        _selectedCharacter = 'CRYBABY';
      } else {
        _selectedCharacter = 'MONSTERS';
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Animation trigger function
  void _triggerAddToCartAnimation() {
    // Use Overlay to show animation above everything else
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    
    overlayEntry = OverlayEntry(
      builder: (context) => AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final product = _allProducts[_currentIndex];
          // Position the animation exactly on top of the cart image
          return Positioned(
            right: 41, // Adjusted to center on cart image (20 + 21 for precise centering)
            top: 83, // Moved down more to perfectly align with cart image
            child: IgnorePointer(
              child: Opacity(
                opacity: (_opacityAnimation.value * (1.0 - (_animationController.value > 0.6 ? (_animationController.value - 0.6) / 0.4 : 0.0))).clamp(0.0, 1.0),
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: 32, // Smaller size to match cart icon size
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.image, color: Colors.grey, size: 16),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    
    overlay.insert(overlayEntry);
    
    _animationController.forward().then((_) {
      overlayEntry.remove();
      _animationController.reset();
    });
  }

  void _goToNextProduct() {
    if (_currentIndex < _allProducts.length - 1) {
      setState(() {
        _currentIndex++;
        // Update selected character when product changes
        final currentProduct = _allProducts[_currentIndex];
        if (currentProduct.name.toUpperCase().contains('LABUBU')) {
          _selectedCharacter = 'LABUBU';
        } else if (currentProduct.name.toUpperCase().contains('CRYBABY')) {
          _selectedCharacter = 'CRYBABY';
        } else {
          _selectedCharacter = 'MONSTERS';
        }
      });
    }
  }

  void _goToPreviousProduct() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        // Update selected character when product changes
        final currentProduct = _allProducts[_currentIndex];
        if (currentProduct.name.toUpperCase().contains('LABUBU')) {
          _selectedCharacter = 'LABUBU';
        } else if (currentProduct.name.toUpperCase().contains('CRYBABY')) {
          _selectedCharacter = 'CRYBABY';
        } else {
          _selectedCharacter = 'MONSTERS';
        }
      });
    }
  }

  void _jumpToProduct(int targetIndex) {
    if (targetIndex >= 0 && targetIndex < _allProducts.length && targetIndex != _currentIndex) {
      setState(() {
        _currentIndex = targetIndex;
        // Update selected character when product changes
        final currentProduct = _allProducts[_currentIndex];
        if (currentProduct.name.toUpperCase().contains('LABUBU')) {
          _selectedCharacter = 'LABUBU';
        } else if (currentProduct.name.toUpperCase().contains('CRYBABY')) {
          _selectedCharacter = 'CRYBABY';
        } else {
          _selectedCharacter = 'MONSTERS';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content - single product view instead of PageView
            _buildProductView(_allProducts[_currentIndex]),
            
            // Navigation arrows - centered on the product image itself
            Positioned(
              left: 33,
              top: 210, // Adjusted for the smaller image height
              child: _currentIndex > 0
                  ? GestureDetector(
                      onTap: _goToPreviousProduct,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.47),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/vectori911-z.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            
            Positioned(
              right: 33,
              top: 210, // Adjusted for the smaller image height
              child: _currentIndex < _allProducts.length - 1
                  ? GestureDetector(
                      onTap: _goToNextProduct,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.47),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/vectori911-yg3.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),

            // Top navigation bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Profile icon (fixed width)
                    GestureDetector(
                      onTap: () {
                        // Profile functionality - no action for now
                      },
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF62528), // Red background
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 24,
                        ),
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
                          return Container(
                            margin: const EdgeInsets.all(0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/cart');
                                  },
                                  child: Container(
                                    width: cart.itemCount > 0 ? 58 : 42, // More compact sizing
                                    height: 42,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF62528), // Red background
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
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
                                        if (cart.itemCount > 0) ...[
                                          const SizedBox(width: 2), // Reduced from 4 to 2
                                          Text(
                                            '${cart.itemCount}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Status image - positioned at bottom right
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  // Navigate to SearchCatalogScreen with custom bottom-to-top transition
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SearchCatalogScreen(selectedCharacter: _selectedCharacter),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.easeOutCubic;

                        var tween = Tween(begin: begin, end: end).chain(
                          CurveTween(curve: curve),
                        );

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/status.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox();
                  },
                ),
              ),
            ),

            // Page indicators - removed from here, moved to inside the column
          ],
        ),
      ),
    );
  }

  Widget _buildProductView(Product product) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        final isInCart = cart.isInCart(product.id);
        final quantity = cart.getQuantity(product.id);

        return Container(
          padding: const EdgeInsets.only(top: 80, bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Product image section with quantity controls
              Container(
                width: double.infinity,
                height: 280, // Reduced from 305 to 280 to fit better
                margin: const EdgeInsets.symmetric(horizontal: 68, vertical: 10), // Reduced vertical margin from 15 to 10
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Simple AnimatedSwitcher for smooth image transitions
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: ClipRRect(
                        key: ValueKey(product.image), // Important: unique key for each image
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFFFBF1EB),
                              child: const Icon(
                                Icons.image,
                                size: 100,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Quantity controls on the image
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Minus button
                            GestureDetector(
                              onTap: () {
                                if (quantity > 1) {
                                  cart.updateQuantity(product.id, quantity - 1);
                                } else if (isInCart) {
                                  cart.removeItem(product.id);
                                }
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/minus.svg',
                                  width: 44,
                                  height: 44,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            // Quantity display
                            Container(
                              width: 60,
                              height: 60,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(
                                  isInCart ? '$quantity' : '1',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Segoe UI',
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            // Plus button
                            GestureDetector(
                              onTap: () {
                                if (isInCart) {
                                  cart.updateQuantity(product.id, quantity + 1);
                                } else {
                                  cart.addItem(product);
                                }
                                // Trigger add to cart animation
                                _triggerAddToCartAnimation();
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/add.svg',
                                  width: 44,
                                  height: 44,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Product info section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 91, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Product name
                    Text(
                      product.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF313131),
                        fontFamily: 'Belanosima',
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                  
                    // Price section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(0)} usd',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFF52428),
                            fontFamily: 'Segoe UI',
                            height: 1,
                          ),
                        ),
                        if (product.oldPrice != null) ...[
                          const SizedBox(width: 12),
                          Text(
                            '(\$${product.oldPrice!.toStringAsFixed(0)})',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF878787),
                              decoration: TextDecoration.lineThrough,
                              fontFamily: 'Segoe UI',
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 50), // Reduced from 70 to 50 to save space
                    
                    // Character section
                    const Text(
                      'Character',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF323232),
                        fontSize: 16,
                        fontFamily: 'Belanosima',
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 20), // Reduced from 25 to 20
                  
                    // Replace old scrollable character Row with:
                    _buildCharacterSelector(),
                    const SizedBox(height: 10), // Reduced spacing
                    
                    // Catalog button with larger dimensions and moved down
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 600),
                            pageBuilder: (context, animation, secondaryAnimation) => const SearchCatalogScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(0.0, 1.0); // bottom of screen
                              const end = Offset.zero;
                              const curve = Curves.easeOutCubic;

                              final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 100, // Increased from 84 to 100
                        height: 100, // Increased from 84 to 100
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22), // Adjusted padding
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), // Slightly larger radius
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/Catalog button.png',
                            width: 56, // Increased from 48
                            height: 56, // Increased from 48
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 56, // Increased from 48
                                height: 56, // Increased from 48
                                padding: const EdgeInsets.all(10), // Increased padding
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF52428),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.grid_view,
                                  color: Colors.white,
                                  size: 32, // Increased from 28
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), // Reduced from 40 to 20 to save space
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }



  // Character Selector
  Widget _buildCharacterSelector() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // MONSTERS
          _buildCharacterButton('MONSTERS', 'assets/images/image28813-q0a-200h.png'),
          // LABUBU  
          _buildCharacterButton('LABUBU', 'assets/images/image28813-jzhv-200h.png'),
          // CRYBABY
          _buildCharacterButton('CRYBABY', 'assets/images/image28813-kr9-200h.png'),
        ],
      ),
    );
  }

  Widget _buildCharacterButton(String character, String imagePath) {
    final isSelected = _selectedCharacter == character;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedCharacter = character;
          });
          final index = _allProducts.indexWhere(
              (p) => p.name.toUpperCase().contains(character.toUpperCase()));
          if (index != -1 && index != _currentIndex) {
            _jumpToProduct(index);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? const Color(0xFFF52428) : Colors.transparent,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
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
            const SizedBox(height: 4),
            FittedBox(
              child: Text(
                character,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: 'Segoe UI',
                  fontWeight: FontWeight.w300,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
