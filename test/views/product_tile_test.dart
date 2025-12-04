import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/views/product_tile.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final testProduct = Product(
    title: 'Test Product',
    original: '£20.00',
    price: '£15.00',
    imageUrl: 'assets/images/hoodie.png',
  );

  testWidgets('ProductTile displays title and price', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: ProductTile(product: testProduct))));
    await tester.pumpAndSettle();

    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('£15.00'), findsOneWidget);
    // thumbnail present (Image.asset) - ensure widget exists
    expect(find.byType(Image), findsWidgets);
  });
}
