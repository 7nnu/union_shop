import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/clothing_collection.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ClothingCollectionPage shows heading and filters (desktop)', (tester) async {
    // simulate a wide/desktop screen to avoid overflow and mobile drawer code paths
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(MaterialApp(
      // lightweight placeholder routes so any navigation doesn't load heavy pages or assets
      routes: {
        '/search': (ctx) => const Scaffold(body: Center(child: Text('SEARCH_PLACEHOLDER'))),
        '/login': (ctx) => const Scaffold(body: Center(child: Text('LOGIN_PLACEHOLDER'))),
        '/cart': (ctx) => const Scaffold(body: Center(child: Text('CART_PLACEHOLDER'))),
        '/merchandise': (ctx) => const Scaffold(body: Center(child: Text('MERCH_PLACEHOLDER'))),
        '/essentials': (ctx) => const Scaffold(body: Center(child: Text('ESSENTIALS_PLACEHOLDER'))),
        '/winter': (ctx) => const Scaffold(body: Center(child: Text('WINTER_PLACEHOLDER'))),
        '/all': (ctx) => const Scaffold(body: Center(child: Text('ALL_PLACEHOLDER'))),
      },
      home: const ClothingCollectionPage(),
    ));

    await tester.pumpAndSettle();

    // Heading present
    expect(find.text('Clothing'), findsOneWidget);

    // Filter / sort labels present
    expect(find.text('FILTER BY'), findsOneWidget);
    expect(find.text('SORT BY'), findsOneWidget);

    // Ensure there is a products area (grid wrapper exists by finding one of the filter dropdowns)
    expect(find.byType(DropdownButton<String>), findsWidgets);
  });
}
