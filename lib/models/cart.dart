import 'package:flutter/foundation.dart';
import 'package:union_shop/models/product.dart';

class CartItem {
  final String id; // unique id per cart entry
  final Product product;
  final String color;
  final String? size; // nullable for merchandise
  final String? personalisationLine1;
  final String? personalisationLine2;
  int quantity;

  CartItem({
    required this.id,
    required this.product,
    required this.color,
    this.size,
    this.personalisationLine1,
    this.personalisationLine2,
    required this.quantity,
  });

  double get unitPrice {
    final s = product.price.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(s) ?? 0.0;
  }

  double get totalPrice => unitPrice * quantity;
}

class Cart extends ChangeNotifier {
  Cart._internal();
  static final Cart _instance = Cart._internal();
  factory Cart() => _instance;

  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();

  int get itemCount => _items.values.fold(0, (v, e) => v + e.quantity);

  double get subtotal => _items.values.fold(0.0, (sum, e) => sum + e.totalPrice);

  // Adds product; if same product+color+size+personalisation exists, increments quantity
  void addProduct(
    Product product, {
    required String color,
    String? size,
    int quantity = 1,
    String? personalisationLine1,
    String? personalisationLine2,
  }) {
    // key composed of product title + color + size + personalisation lines for simple dedupe
    final key = '${product.title}||$color||${size ?? ''}||${personalisationLine1 ?? ''}||${personalisationLine2 ?? ''}';
    if (_items.containsKey(key)) {
      _items[key]!.quantity += quantity;
    } else {
      _items[key] = CartItem(
        id: key,
        product: product,
        color: color,
        size: size,
        personalisationLine1: personalisationLine1,
        personalisationLine2: personalisationLine2,
        quantity: quantity,
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void updateQuantity(String id, int quantity) {
    final item = _items[id];
    if (item == null) return;
    if (quantity <= 0) {
      _items.remove(id);
    } else {
      item.quantity = quantity;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
