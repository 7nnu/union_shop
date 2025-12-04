
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/views/product_tile.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Home Page Tests', () {
    testWidgets('shows hero title and CTA', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      expect(find.text('Essential Range - Over 20% OFF!'), findsOneWidget);
      expect(find.text('BROWSE COLLECTION'), findsOneWidget);
      expect(find.text('VIEW ALL COLLECTIONS'), findsOneWidget);
    });

    testWidgets('shows section headings', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Section headings present on the home screen
      expect(find.text('ESSENTIAL RANGE - OVER 20% OFF!'), findsOneWidget);
      expect(find.text('MERCHANDISE COLLECTION!'), findsOneWidget);
    });

    testWidgets('renders at least one product tile', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Ensure product tiles are present on the home page
      expect(find.byType(ProductTile), findsWidgets);
    });
  });
}
