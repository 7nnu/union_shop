import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/merchandise_collection.dart';
import 'package:union_shop/views/custom_header.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('MerchandiseCollectionPage renders heading and filters on desktop', (tester) async {
    // desktop viewport
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const MaterialApp(home: MerchandiseCollectionPage()));
    await tester.pumpAndSettle();

    // heading text present
    expect(find.text('Merchandise'), findsOneWidget);

    // header + filter labels
    expect(find.byType(CustomHeader), findsOneWidget);
    expect(find.text('FILTER BY'), findsOneWidget);
    expect(find.text('SORT BY'), findsOneWidget);
  });
}
