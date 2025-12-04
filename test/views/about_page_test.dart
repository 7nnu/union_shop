import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/about_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('AboutPage renders main desktop content', (tester) async {
    // simulate desktop viewport
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const MaterialApp(home: AboutPage()));
    await tester.pumpAndSettle();

    // main headings and paragraphs
    expect(find.text('About us'), findsOneWidget);
    expect(find.text('Welcome to the Union Shop!'), findsOneWidget);
    expect(find.text('Happy shopping!'), findsOneWidget);

    // header shows desktop nav items (top-level)
    expect(find.text('Shop'), findsOneWidget);
    expect(find.text('The Print Shack'), findsOneWidget);
  });
}
