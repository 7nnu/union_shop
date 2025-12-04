import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/winter_collection.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('WinterCollectionPage shows heading and filters (desktop)', (tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const MaterialApp(home: WinterCollectionPage()));
    await tester.pumpAndSettle();

    expect(find.text('Winter'), findsOneWidget);
    expect(find.text('FILTER BY'), findsOneWidget);
    expect(find.byType(DropdownButton<String>), findsWidgets);
  });
}
