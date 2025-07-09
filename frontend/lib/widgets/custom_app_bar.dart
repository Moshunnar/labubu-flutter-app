import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          // Navigate to home page
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF52428), // POP MART Red
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/popartlogo8113-eu4u-200h.png',
            height: 25,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.star, color: Color(0xFFF52428), size: 25);
            },
          ),
          const Text(
            'LABuBu',
            style: TextStyle(
              color: Color(0xFFFFC300),
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'CherryBombOne',
              height: 1,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        Container(
          width: 80, // Increased to accommodate cart count properly
          margin: const EdgeInsets.only(right: 16),
          child: Consumer<CartModel>(
            builder: (context, cart, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                    child: Container(
                      width: cart.itemCount > 0 ? 60 : 42, // Increase width when there's a count
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
                            const SizedBox(width: 4),
                            Text(
                              '${cart.itemCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Belanosima',
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
