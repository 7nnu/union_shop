import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/about_page.dart';
import 'package:union_shop/views/custom_header.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AboutPage (view tests)', () {
    testWidgets('renders main content on desktop', (tester) async {
      // simulate desktop
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

      // header shows desktop nav items
      expect(find.text('Shop'), findsOneWidget);
      expect(find.text('The Print Shack'), findsOneWidget);
    });

    testWidgets('mobile: tapping header search navigates to /search', (tester) async {
      // simulate mobile
      tester.binding.window.physicalSizeTestValue = const Size(360, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
        tester.binding.window.clearDevicePixelRatioTestValue();
      });

      await tester.pumpWidget(MaterialApp(
        routes: {
          '/search': (ctx) => const Scaffold(body: Center(child: Text('SEARCH_PLACEHOLDER'))),
        },
        home: const AboutPage(),
      ));
      await tester.pumpAndSettle();

      // menu icon should exist on mobile header
      expect(find.byIcon(Icons.menu), findsOneWidget);

      // find the header search icon and tap it
      final headerSearch = find.descendant(of: find.byType(CustomHeader), matching: find.byIcon(Icons.search));
      expect(headerSearch, findsOneWidget);
      await tester.tap(headerSearch);
      await tester.pumpAndSettle();

      // navigated to placeholder search route
      expect(find.text('SEARCH_PLACEHOLDER'), findsOneWidget);
    });

    testWidgets('mobile: open menu and navigate to Personalisation placeholder', (tester) async {
      // simulate mobile
      tester.binding.window.physicalSizeTestValue = const Size(360, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
        tester.binding.window.clearDevicePixelRatioTestValue();
      });

      await tester.pumpWidget(MaterialApp(
        routes: {
          '/printshack-personalisation': (ctx) => const Scaffold(body: Center(child: Text('PERSONALISATION_PLACEHOLDER'))),
        },
        home: const AboutPage(),
      ));
      await tester.pumpAndSettle();

      // open mobile menu
      final menuBtn = find.byIcon(Icons.menu);
      expect(menuBtn, findsOneWidget);
      await tester.tap(menuBtn);
      await tester.pumpAndSettle();

      // ensure "Personalisation" entry exists and tap it
      expect(find.text('Personalisation'), findsWidgets);
      final personalTile = find.widgetWithText(ListTile, 'Personalisation').first;
      await tester.tap(personalTile);
      await tester.pumpAndSettle();

      // navigated to placeholder
      expect(find.text('PERSONALISATION_PLACEHOLDER'), findsOneWidget);
    });
  });
}
