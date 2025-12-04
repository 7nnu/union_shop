import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/collections_overview.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('CollectionsOverviewPage builds on desktop and has header', (tester) async {
    // desktop viewport
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const MaterialApp(home: CollectionsOverviewPage()));
    await tester.pumpAndSettle();

    // Page builds and provides a Scaffold
    expect(find.byType(Scaffold), findsOneWidget);

    // top-level header nav should be present on desktop
    expect(find.text('Shop'), findsOneWidget);
  });
}
