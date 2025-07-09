import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/product_detail_screen.dart';
import 'screens/search_catalog_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'models/cart_model.dart';
import 'models/product.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const LabubuApp());
}

class LabubuApp extends StatelessWidget {
  const LabubuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp(
        title: 'POP MART LABUBU',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: const Color(0xFFF52428), // Authentic POP MART Red
          scaffoldBackgroundColor: const Color(0xFFFBFAF9), // Neutral Light
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            iconTheme: IconThemeData(color: Color(0xFF191818)), // Neutral Dark
            titleTextStyle: TextStyle(
              color: Color(0xFF191818),
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Belanosima',
            ),
          ),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF191818),
              fontFamily: 'CherryBombOne',
            ),
            headlineMedium: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xFF191818),
              fontFamily: 'Belanosima',
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              color: Color(0xFF2F2F2F), // Default Body Text
              fontFamily: 'Belanosima',
            ),
            bodyMedium: TextStyle(
              fontSize: 14,
              color: Color(0xFF616161), // Default Body Text 2
              fontFamily: 'Belanosima',
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF52428), // POP MART Red
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24), // Button Radius from CSS
              ),
            ),
          ),
          cardTheme: const CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)), // Card Radius from CSS
            ),
            color: Colors.white,
          ),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => ProductDetailScreen(
            product: Product(
              id: 'default_1',
              name: 'THE MONSTERS Big into Energy Series-Vinyl Plush Pendant Blind Box (secret box)',
              price: 60.00,
              oldPrice: 120.00,
              image: 'assets/images/image31258-zg4-200h.png',
              description: 'Big into Energy Series pendant blind box',
            ),
          ),
          '/search': (context) => const SearchCatalogScreen(),
          '/cart': (context) => const CartScreen(),
          '/checkout': (context) => const CheckoutScreen(),
        },
      ),
    );
  }
}
