import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/views/product_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // lightweight test product
  final testProduct = Product(
    title: 'Test Hoodie',
    original: '£40.00',
    price: '£30.00',
    imageUrl: 'assets/images/hoodie.png',
  );

  Widget createTestApp() {
    return MaterialApp(
      routes: {
        '/product': (ctx) => const ProductPage(),
      },
      home: Builder(
        builder: (ctx) {
          // push the product route with arguments after the first frame
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(ctx, '/product', arguments: testProduct);
          });
          return const SizedBox.shrink();
        },
      ),
    );
  }

  group('Product Page Tests', () {

    testWidgets('shows option selectors and add to cart button', (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // option labels
      expect(find.text('Color'), findsOneWidget);
      expect(find.text('Size'), findsOneWidget);
      expect(find.text('Quantity'), findsOneWidget);

      // Add to cart button present
      expect(find.widgetWithText(OutlinedButton, 'ADD TO CART'), findsOneWidget);
    });

    testWidgets('header icons present (profile & cart)', (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // header contains profile and cart icons
      expect(find.byIcon(Icons.person_outline), findsWidgets);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsWidgets);
    });
  });
}
