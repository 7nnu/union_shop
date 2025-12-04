import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/printshack_about.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('PrintShackAboutPage renders title and key text (desktop)', (tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const MaterialApp(home: PrintShackAboutPage()));
    await tester.pumpAndSettle();

    expect(find.text('The Union Print Shack'), findsOneWidget);
    expect(find.textContaining('Personalisation', findRichText: false), findsWidgets);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
