import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/cart_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('CartPage shows empty cart message and header icons', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CartPage()));
    await tester.pumpAndSettle();

    // Empty cart message is shown by default
    expect(find.text('Your cart is empty'), findsOneWidget);

    // Header icons present (search/profile/cart/menu may be present in header)
    expect(find.byIcon(Icons.search), findsWidgets);
    expect(find.byIcon(Icons.shopping_bag_outlined), findsWidgets);
  });
}
