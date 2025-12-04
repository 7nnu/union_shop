import 'package:flutter/material.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:union_shop/views/about_page.dart';
import 'package:union_shop/views/custom_header.dart';
import 'package:union_shop/views/custom_footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/data/products.dart';
import 'package:union_shop/views/product_tile.dart';
import 'package:union_shop/views/login_page.dart';
import 'package:union_shop/views/clothing_collection.dart';
import 'package:union_shop/views/essentials_collection.dart';
import 'package:union_shop/views/search_page.dart';
import 'package:union_shop/views/winter_collection.dart';
import 'package:union_shop/views/merchandise_collection.dart';
import 'package:union_shop/views/all_collection.dart';
import 'package:union_shop/views/sale_collection.dart';
import 'package:union_shop/views/order_confirmation.dart';
import 'package:union_shop/views/collections_overview.dart';
import 'package:union_shop/views/cart_page.dart';
import 'package:union_shop/views/printshack_about.dart';
import 'package:union_shop/views/printshack_personalisation.dart';
import 'package:union_shop/views/home_screen.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: HomeScreen(),
      initialRoute: '/',
      routes: {
        '/product': (context) => const ProductPage(),
        '/about': (context) => const AboutPage(),
        '/printshack-personalisation': (context) => const PrintShackPersonalisationPage(),
        '/login': (context) => const LoginPage(),
        '/printshack-about': (context) => const PrintShackAboutPage(),
        '/order-confirmation': (context) => const OrderConfirmationPage(),
        '/cart': (context) => const CartPage(),
        '/clothing': (context) => const ClothingCollectionPage(),
        '/essentials': (context) => const EssentialsCollectionPage(),
        '/merchandise': (context) => const MerchandiseCollectionPage(),
        '/sale': (context) => const SaleCollectionPage(),
        '/winter': (context) => const WinterCollectionPage(),
        '/all': (context) => const AllCollectionPage(),
        '/collections': (context) => const CollectionsOverviewPage(),
        '/search': (context) => const SearchPage(),
      },
    );
  }
}
