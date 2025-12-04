import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/printshack_personalisation.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('PrintShackPersonalisationPage shows options and add button (desktop)', (tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const MaterialApp(home: PrintShackPersonalisationPage()));
    await tester.pumpAndSettle();

    expect(find.text('Personalisation'), findsOneWidget);
    expect(find.byType(DropdownButton<String>), findsWidgets);
    expect(find.widgetWithText(OutlinedButton, 'ADD TO CART'), findsOneWidget);
  });
}
