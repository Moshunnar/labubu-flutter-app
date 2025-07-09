import 'package:flutter/material.dart';

class LabubuCheckoutScreen extends StatelessWidget {
  const LabubuCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Stack(
                    children: [
                      // Back Button
                      Positioned(
                        left: 16,
                        top: 16,
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF52428),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      // Logo
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 24,
                        child: Column(
                          children: [
                            Container(
                              width: 84,
                              height: 25,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFFFC300),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'POP MART',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontFamily: 'Segoe UI',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'LABuBu',
                              style: TextStyle(
                                color: Color(0xFFFFC300),
                                fontSize: 32,
                                fontFamily: 'CherryBombOne',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Cart Button
                      Positioned(
                        right: 16,
                        top: 16,
                        child: Container(
                          height: 42,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF52428),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Belanosima',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Product Detail Section
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Stack(
                    children: [
                      // Main Product Image
                      Positioned(
                        left: 24,
                        top: 20,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 48,
                          height: 305,
                          decoration: ShapeDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/images/tq_j98dbrzss4-cluq-400h.png'),
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Quantity Controls
                              Positioned(
                                left: 20,
                                bottom: 20,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 100,
                                bottom: 20,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '2',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Segoe UI',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 20,
                                bottom: 20,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      // Product Info
                      Positioned(
                        left: 24,
                        bottom: 20,
                        right: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'THE MONSTERS Big into Energy Series-Vinyl Plush Pendant Blind Box (secret box)',
                              style: TextStyle(
                                color: Color(0xFF313131),
                                fontSize: 15,
                                fontFamily: 'Belanosima',
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Text(
                                  '\$60 usd',
                                  style: TextStyle(
                                    color: Color(0xFF313131),
                                    fontSize: 15,
                                    fontFamily: 'Segoe UI',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '(\$120)',
                                  style: TextStyle(
                                    color: Color(0xFFD9D9D9),
                                    fontSize: 13,
                                    fontFamily: 'Segoe UI',
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                // Color Options
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: ShapeDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage('assets/images/tq_hn6g9bj3dg-6iu4-200h.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: ShapeDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage('assets/images/tq_lbgyh4hzbw-xot7-200h.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: ShapeDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage('assets/images/tq_yc0rofrozb-n29e-200h.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 520,
                  ),
                  decoration: const ShapeDecoration(
                    color: Color(0xFFF52428),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(42),
                        topRight: Radius.circular(42),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Search Bar
                      Container(
                        margin: const EdgeInsets.all(24),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Search for your Labubu name..',
                                style: TextStyle(
                                  color: Color(0xFF878787),
                                  fontSize: 15,
                                  fontFamily: 'Segoe UI',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.search,
                              color: Color(0xFF878787),
                            ),
                          ],
                        ),
                      ),
                      
                      // Product List
                      Container(
                        height: 400,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: _buildProductList(),
                      ),
                      
                      // Payment Summary
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Payment Summary',
                                style: TextStyle(
                                  color: Color(0xFF313131),
                                  fontSize: 17,
                                  fontFamily: 'Belanosima',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildSummaryRow('Basket Total', '\$459.98'),
                            _buildSummaryRow('Promo Code', '\$0'),
                            _buildSummaryRow('Tax - (5%)', '\$22.99'),
                            _buildSummaryRow('Delivery Fee', '\$15'),
                            const Divider(height: 24),
                            _buildSummaryRow('Order Total (incl. tax)', '\$497.97', isTotal: true),
                            const SizedBox(height: 24),
                            
                            // Delivery Address
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF52428),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deliver to:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'Segoe UI',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Marina Heights Tower Unit No: 1505\nMarina Walk, Al Kahyay St., Dubai',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Segoe UI',
                                      fontWeight: FontWeight.w400,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            
                            // Payment Method
                            const Row(
                              children: [
                                Icon(Icons.credit_card, color: Color(0xFF878787)),
                                SizedBox(width: 8),
                                Text(
                                  '•• 4589',
                                  style: TextStyle(
                                    color: Color(0xFF878787),
                                    fontSize: 17,
                                    fontFamily: 'Segoe UI',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            
                            // Pay Button
                            Container(
                              width: double.infinity,
                              height: 56,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF52428),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Pay \$497.97',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: 'Segoe UI',
                                    fontWeight: FontWeight.w700,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildProductList() {
    return ListView(
      children: [
        _buildProductCard(
          'assets/images/tq_j98dbrzss4-cluq-400h.png',
          'THE MONSTERS Big into Energy Series-Vinyl Plush Pendant Blind Box (secret box)',
          '\$60 usd',
          '(\$120)',
          '1',
        ),
        _buildProductCard(
          'assets/images/tq_nvrpwrz7ut-4e4-400h.png',
          'THE MONSTERS - ANGEL IN CLOUDS Vinyl Face Doll',
          '\$299.99 usd',
          '(\$320)',
          null,
        ),
        _buildProductCard(
          'assets/images/tq_lloihwy0qv-ancp-400h.png',
          'THE MONSTERS - I FOUND YOU Vinyl Face Doll',
          '\$99.99 usd',
          '(\$120)',
          null,
        ),
      ],
    );
  }
  
  Widget _buildProductCard(String imagePath, String title, String price, String originalPrice, String? quantity) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 100,
            height: 100,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                if (quantity != null)
                  Positioned(
                    left: 34,
                    bottom: 6,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          quantity,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Segoe UI',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                // Action buttons
                Positioned(
                  right: 6,
                  bottom: 6,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 14,
                    ),
                  ),
                ),
                if (quantity == null)
                  Positioned(
                    left: 6,
                    bottom: 6,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.black,
                        size: 14,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Belanosima',
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Segoe UI',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      originalPrice,
                      style: const TextStyle(
                        color: Color(0xFFD9D9D9),
                        fontSize: 12,
                        fontFamily: 'Segoe UI',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSummaryRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF2F2F2F),
              fontSize: 17,
              fontFamily: 'Segoe UI',
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: const Color(0xFF2F2F2F),
              fontSize: 17,
              fontFamily: 'Segoe UI',
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
