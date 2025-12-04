import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/all_collection.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('AllCollectionPage shows heading and filter controls (desktop)', (tester) async {
    // simulate a wide/desktop screen to avoid mobile drawer and overflow issues
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(MaterialApp(
      // lightweight placeholder routes to avoid loading heavy pages/assets during tests
      routes: {
        '/search': (ctx) => const Scaffold(body: Center(child: Text('SEARCH_PLACEHOLDER'))),
        '/login': (ctx) => const Scaffold(body: Center(child: Text('LOGIN_PLACEHOLDER'))),
        '/cart': (ctx) => const Scaffold(body: Center(child: Text('CART_PLACEHOLDER'))),
        '/clothing': (ctx) => const Scaffold(body: Center(child: Text('CLOTHING_PLACEHOLDER'))),
        '/merchandise': (ctx) => const Scaffold(body: Center(child: Text('MERCH_PLACEHOLDER'))),
        '/essentials': (ctx) => const Scaffold(body: Center(child: Text('ESSENTIALS_PLACEHOLDER'))),
        '/winter': (ctx) => const Scaffold(body: Center(child: Text('WINTER_PLACEHOLDER'))),
        '/all': (ctx) => const Scaffold(body: Center(child: Text('ALL_PLACEHOLDER'))),
      },
      home: const AllCollectionPage(),
    ));

    await tester.pumpAndSettle();

    // Page heading
    expect(find.text('All Products'), findsOneWidget);

    // Filter / sort labels
    expect(find.text('FILTER BY'), findsOneWidget);
    expect(find.text('SORT BY'), findsOneWidget);

    // Ensure dropdowns are present
    expect(find.byType(DropdownButton<String>), findsWidgets);

    // Ensure scaffold (page) is present
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
