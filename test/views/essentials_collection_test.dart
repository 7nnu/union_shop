import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/essentials_collection.dart';
import 'package:union_shop/views/custom_header.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('EssentialsCollectionPage renders desktop heading and filter controls', (tester) async {
    // desktop viewport
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const MaterialApp(home: EssentialsCollectionPage()));
    await tester.pumpAndSettle();

    // page builds
    expect(find.byType(Scaffold), findsOneWidget);

    // header present
    expect(find.byType(CustomHeader), findsOneWidget);

    // filter / sort labels present
    expect(find.text('FILTER BY'), findsOneWidget);
    expect(find.text('SORT BY'), findsOneWidget);
  });
}
