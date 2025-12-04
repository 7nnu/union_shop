import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/login_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('LoginPage builds and provides a scaffold (desktop)', (tester) async {
    // desktop viewport
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    await tester.pumpAndSettle();

    // basic smoke checks
    expect(find.byType(Scaffold), findsOneWidget);
    // presence of a primary action/button or textual 'Login' is acceptable if present
    expect(find.textContaining('Login', findRichText: false), findsWidgets);
  });
}
