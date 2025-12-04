import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/order_confirmation.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('OrderConfirmationPage shows order heading and empty state (desktop)', (tester) async {
    // desktop viewport
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const MaterialApp(home: OrderConfirmationPage()));
    await tester.pumpAndSettle();

    // Known texts from the page
    expect(find.text('Order Number 0000'), findsOneWidget);
    expect(find.text('No items in order'), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
