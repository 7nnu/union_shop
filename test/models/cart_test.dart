import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/product.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Cart cart;

  setUp(() {
    cart = Cart();
    cart.clear();
  });

  tearDown(() {
    cart.clear();
  });

  test('addProduct increases items and subtotal', () {
    final product = Product(title: 'Test Hoodie', original: '£40.00', price: '£30.00', imageUrl: 'assets/images/hoodie.png');

    expect(cart.items.length, 0);
    cart.addProduct(product, color: 'Black', size: 'M', quantity: 2);

    expect(cart.items.isNotEmpty, true);
    final item = cart.items.first;
    expect(item.product.title, 'Test Hoodie');
    expect(item.quantity, 2);
    expect(cart.subtotal > 0, true);
  });

  test('updateQuantity changes quantity and subtotal', () {
    final product = Product(title: 'Qty Test', original: '', price: '£10.00', imageUrl: 'assets/images/hoodie.png');
    cart.addProduct(product, color: 'Black', size: 'L', quantity: 1);
    final item = cart.items.first;
    final id = item.id;

    final beforeSubtotal = cart.subtotal;
    cart.updateQuantity(id, 3);

    final updated = cart.items.firstWhere((i) => i.id == id);
    expect(updated.quantity, 3);
    expect(cart.subtotal > beforeSubtotal, true);
  });

  test('removeItem deletes an item', () {
    final product = Product(title: 'Remove Test', original: '', price: '£5.00', imageUrl: 'assets/images/hoodie.png');
    cart.addProduct(product, color: 'Black', size: null, quantity: 1);
    final item = cart.items.first;
    expect(cart.items.length, 1);

    cart.removeItem(item.id);
    expect(cart.items.length, 0);
    expect(cart.subtotal, 0.0);
  });

  test('clear empties the cart', () {
    final p1 = Product(title: 'A', original: '', price: '£3.00', imageUrl: 'assets/images/hoodie.png');
    final p2 = Product(title: 'B', original: '', price: '£4.00', imageUrl: 'assets/images/hoodie.png');
    cart.addProduct(p1, color: 'N', size: null, quantity: 1);
    cart.addProduct(p2, color: 'N', size: null, quantity: 2);
    expect(cart.items.length, greaterThanOrEqualTo(2));

    cart.clear();
    expect(cart.items.length, 0);
    expect(cart.subtotal, 0.0);
  });

  test('listeners are notified on changes', () {
    var called = false;
    void listener() => called = true;

    cart.addListener(listener);
    final product = Product(title: 'Listen Test', original: '', price: '£2.00', imageUrl: 'assets/images/hoodie.png');
    cart.addProduct(product, color: 'N', size: null, quantity: 1);

    expect(called, true);
    cart.removeListener(listener);
  });
}
