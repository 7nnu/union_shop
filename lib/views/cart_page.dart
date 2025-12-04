import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/views/custom_header.dart';
import 'package:union_shop/views/custom_footer.dart';
import 'package:union_shop/views/search_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Cart cart = Cart();
  final Map<String, bool> _hovering = {};
  bool _mobileMenuOpen = false;

  void _setHover(String name, bool val) => setState(() => _hovering[name] = val);
  void _toggleMobileMenu() => setState(() => _mobileMenuOpen = !_mobileMenuOpen);

  Widget _drawerContent(BuildContext context, {bool showTopIcons = true}) {
    final children = <Widget>[];
    if (showTopIcons) {
      children.add(Container(
        color: const Color(0xFF4d2963),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(children: [
          Image.network('https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854', height: 36, errorBuilder: (c, e, s) => const SizedBox(width: 36, height: 36)),
          const Spacer(),
          IconButton(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.all(6),
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              final isMobileLocal = MediaQuery.of(context).size.width < 700;
              if (showTopIcons) Navigator.pop(context);
              if (isMobileLocal) Navigator.pushNamed(context, '/search');
              else showSearch(context: context, delegate: ProductSearchDelegate());
            },
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.all(6),
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: () { if (showTopIcons) Navigator.pop(context); Navigator.pushNamed(context, '/login'); },
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.all(6),
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
            onPressed: () { if (showTopIcons) Navigator.pop(context); Navigator.pushNamed(context, '/cart'); },
          ),
        ]),
      ));
    }

    children.addAll([
      ListTile(title: const Text('Home'), onTap: () { if (showTopIcons) Navigator.pop(context); Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false); }),
      const Divider(height: 1),
      ExpansionTile(title: const Text('Shop'), children: [
        ListTile(title: const Text('Clothing'), onTap: () { if (showTopIcons) Navigator.pop(context); Navigator.pushNamed(context, '/clothing'); }),
        ListTile(title: const Text('Merchandise'), onTap: () { if (showTopIcons) Navigator.pop(context); Navigator.pushNamed(context, '/merchandise'); }),
        ListTile(title: const Text('Essentials'), onTap: () { if (showTopIcons) Navigator.pop(context); Navigator.pushNamed(context, '/essentials'); }),
        ListTile(title: const Text('Winter'), onTap: () { if (showTopIcons) Navigator.pop(context); Navigator.pushNamed(context, '/winter'); }),
        ListTile(title: const Text('All'), onTap: () { if (showTopIcons) Navigator.pop(context); Navigator.pushNamed(context, '/all'); }),
      ]),
      const Divider(height: 1),
      ExpansionTile(title: const Text('The Print Shack'), children: [
        ListTile(title: const Text('About'), onTap: () { if (showTopIcons) Navigator.pop(context); Navigator.pushNamed(context, '/printshack-about'); }),
        ListTile(title: const Text('Personalisation'), onTap: () { if (showTopIcons) Navigator.pop(context); Navigator.pushNamed(context, '/printshack-personalisation'); }),
      ]),
      const Divider(height: 1),
      ListTile(title: const Text('SALE!', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), onTap: () { if (showTopIcons) Navigator.pop(context); Navigator.pushNamed(context, '/sale'); }),
      const Divider(height: 1),
      ListTile(title: const Text('About'), onTap: () { if (showTopIcons) Navigator.pop(context); Navigator.pushNamed(context, '/about'); }),
    ]);

    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
  }

  @override
  void initState() {
    super.initState();
    cart.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    cart.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final headerHeight = isMobile ? 120.0 : 130.0;
    final remainingHeight = MediaQuery.of(context).size.height - headerHeight;

    return Scaffold(
      drawer: null,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CustomHeader(
                  isMobile: isMobile,
                  activeNav: 'Cart',
                  hovering: _hovering,
                  onHover: _setHover,
                  onSetActive: (_) {},
                  placeholderCallback: () => Navigator.pushNamed(context, '/login'),
                  toggleMobileMenu: _toggleMobileMenu,
                  mobileMenuOpen: _mobileMenuOpen,
                  navigateToHome: (ctx) => Navigator.pushNamedAndRemoveUntil(ctx, '/', (r) => false),
                  navigateToProduct: (ctx) => Navigator.pushNamed(ctx, '/product'),
                  navigateToAbout: (ctx) => Navigator.pushNamed(ctx, '/about'),
                  navigateToClothing: (ctx) => Navigator.pushNamed(ctx, '/clothing'),
                  navigateToEssentials: (ctx) => Navigator.pushNamed(ctx, '/essentials'),
                  navigateToMerchandise: (ctx) => Navigator.pushNamed(ctx, '/merchandise'),
                  navigateToSale: (ctx) => Navigator.pushNamed(ctx, '/sale'),
                  navigateToAll: (ctx) => Navigator.pushNamed(ctx, '/all'),
                  navigateToSearch: (ctx) {
                    final isMobileLocal = MediaQuery.of(ctx).size.width < 700;
                    if (isMobileLocal) Navigator.pushNamed(ctx, '/search');
                    else showSearch(context: ctx, delegate: ProductSearchDelegate());
                  },
                  navigateToWinter: (ctx) => Navigator.pushNamed(ctx, '/winter'),
                ),

                Padding(
                  padding: EdgeInsets.all(isMobile ? 12 : 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Shopping Cart', style: TextStyle(fontSize: isMobile ? 20 : 28, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),

                      if (cart.items.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Center(child: Text('Your cart is empty', style: TextStyle(fontSize: 16, color: Colors.grey.shade700))),
                        )
                      else
                        Column(
                          children: [
                            ...cart.items.map((item) {
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: isMobile ? 80 : 120,
                                        height: isMobile ? 80 : 120,
                                        child: Image.asset(item.product.imageUrl, fit: BoxFit.cover),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(item.product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 6),
                                            Text('Color: ${item.color}', style: const TextStyle(color: Colors.grey)),
                                            // show personalisation lines if present
                                            if (item.personalisationLine1 != null && item.personalisationLine1!.isNotEmpty) ...[
                                              const SizedBox(height: 4),
                                              Text('Line 1: ${item.personalisationLine1}', style: const TextStyle(color: Colors.grey)),
                                            ],
                                            if (item.personalisationLine2 != null && item.personalisationLine2!.isNotEmpty) ...[
                                              const SizedBox(height: 4),
                                              Text('Line 2: ${item.personalisationLine2}', style: const TextStyle(color: Colors.grey)),
                                            ],
                                            if (item.size != null) const SizedBox(height: 4),
                                            if (item.size != null) Text('Size: ${item.size}', style: const TextStyle(color: Colors.grey)),
                                            const SizedBox(height: 8),
                                            Text('Unit: ${item.product.price}', style: const TextStyle(fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.remove_circle_outline),
                                                onPressed: () {
                                                  final newQty = item.quantity - 1;
                                                  cart.updateQuantity(item.id, newQty);
                                                },
                                              ),
                                              Text('${item.quantity}', style: const TextStyle(fontSize: 16)),
                                              IconButton(
                                                icon: const Icon(Icons.add_circle_outline),
                                                onPressed: () {
                                                  cart.updateQuantity(item.id, item.quantity + 1);
                                                },
                                              ),
                                            ],
                                          ),
                                          Text('£${(item.totalPrice).toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                          IconButton(
                                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                                            onPressed: () => cart.removeItem(item.id),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),

                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Subtotal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                Text('£${cart.subtotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // snapshot current cart items and navigate to confirmation
                                  final orderItems = cart.items.map((i) => i).toList();
                                  Navigator.pushNamed(context, '/order-confirmation', arguments: orderItems);
                                  cart.clear();
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4d2963), padding: const EdgeInsets.symmetric(vertical: 16)),
                                child: const Text('CHECKOUT', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),

                      const SizedBox(height: 24),
                      const CustomFooter(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (_mobileMenuOpen)
            Positioned(
              top: headerHeight,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                constraints: BoxConstraints(maxHeight: remainingHeight),
                decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2))]),
                child: SingleChildScrollView(child: _drawerContent(context, showTopIcons: false)),
              ),
            ),
        ],
      ),
    );
  }
}
