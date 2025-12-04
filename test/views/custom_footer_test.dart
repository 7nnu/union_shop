import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/custom_footer.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('CustomFooter renders expected sections on desktop', (tester) async {
    // simulate desktop viewport
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: CustomFooter())));
    await tester.pumpAndSettle();

    // Basic footer headings (adjust if your CustomFooter uses different text)
    expect(find.textContaining('Latest'), findsWidgets);
    expect(find.textContaining('Help'), findsWidgets);
  });
}
