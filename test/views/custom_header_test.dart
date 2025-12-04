import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/custom_header.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('CustomHeader renders desktop nav and icons', (tester) async {
    // simulate desktop viewport
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    // Minimal callbacks and state required by CustomHeader
    final hovering = <String, bool>{};
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomHeader(
          isMobile: false,
          activeNav: 'Home',
          hovering: hovering,
          onHover: (n, v) {},
          onSetActive: (s) {},
          placeholderCallback: () {},
          toggleMobileMenu: () {},
          mobileMenuOpen: false,
          navigateToHome: (ctx) {},
          navigateToProduct: (ctx) {},
          navigateToAbout: (ctx) {},
          navigateToClothing: (ctx) {},
          navigateToEssentials: (ctx) {},
          navigateToMerchandise: (ctx) {},
          navigateToSale: (ctx) {},
          navigateToAll: (ctx) {},
          navigateToSearch: (ctx) {},
          navigateToWinter: (ctx) {},
        ),
      ),
    ));
    await tester.pumpAndSettle();

    // Top-level nav labels expected on desktop
    expect(find.text('Shop'), findsOneWidget);
    expect(find.text('The Print Shack'), findsOneWidget);
    expect(find.text('SALE!'), findsOneWidget);

    // Icons
    expect(find.byIcon(Icons.search), findsWidgets);
    expect(find.byIcon(Icons.person_outline), findsWidgets);
    expect(find.byIcon(Icons.shopping_bag_outlined), findsWidgets);
  });
}
