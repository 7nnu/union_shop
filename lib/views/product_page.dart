import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/views/custom_header.dart';
import 'package:union_shop/views/custom_footer.dart';
import 'package:union_shop/views/search_page.dart';
import 'package:union_shop/models/cart.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _mobileMenuOpen = false;
  final Map<String, bool> _hovering = {};

  // product option state
  String _selectedColor = 'Black';
  String _selectedSize = 'L';
  int _quantity = 1;

  // helper: determine if product is merchandise (tote/mug/notebook/pen/lanyard)
  bool _isMerchandise(Product p) {
    final t = p.title.toLowerCase();
    return t.contains('tote') || t.contains('mug') || t.contains('notebook') || t.contains('pen') || t.contains('lanyard');
  }

  // determine which collection route a product belongs to
  String _collectionRouteForProduct(Product p) {
    final t = p.title.toLowerCase();
    if (t.contains('essential')) return '/essentials';
    if (t.contains('hoodie') || t.contains('t-shirt') || t.contains('tshirt') || t.contains('jacket')) return '/clothing';
    if (t.contains('tote') || t.contains('mug') || t.contains('notebook') || t.contains('pen') || t.contains('lanyard')) return '/merchandise';
    if (t.contains('winter') || t.contains('scarf') || t.contains('glove') || t.contains('beanie')) return '/winter';
    return '/all';
  }

  void _toggleMobileMenu() => setState(() => _mobileMenuOpen = !_mobileMenuOpen);
  void _setHover(String name, bool val) => setState(() => _hovering[name] = val);
  void _setActive(String name) {
    // no-op visual active state; pages can override as needed
  }

  Widget _drawerContent(BuildContext context, {bool showTopIcons = true}) {
    final children = <Widget>[];
    if (showTopIcons) {
      children.add(Container(
        color: const Color(0xFF4d2963),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Image.network(
              'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
              height: 36,
              errorBuilder: (c, e, s) => const SizedBox(width: 36, height: 36),
            ),
          ],
        ),
      ));
    }
    children.addAll([
      ListTile(title: const Text('Home'), onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false)),
      const Divider(height: 1),
      ListTile(title: const Text('Clothing'), onTap: () => Navigator.pushNamed(context, '/clothing')),
      ListTile(title: const Text('Merchandise'), onTap: () => Navigator.pushNamed(context, '/merchandise')),
      ListTile(title: const Text('Essentials'), onTap: () => Navigator.pushNamed(context, '/essentials')),
      ListTile(title: const Text('Winter'), onTap: () => Navigator.pushNamed(context, '/winter')),
    ]);
    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final Product? product = args is Product ? args : null;

    final isMobile = MediaQuery.of(context).size.width < 700;
    final headerHeight = isMobile ? 120.0 : 130.0;
    final remainingHeight = MediaQuery.of(context).size.height - headerHeight;

    if (product == null) {
      return Scaffold(
        appBar: AppBar(backgroundColor: const Color(0xFF4d2963), title: const Text('Product')),
        body: const Center(child: Text('No product selected')),
      );
    }

    return Scaffold(
      drawer: null, // ensure header's in-tree slide-down is used
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CustomHeader(
                  isMobile: isMobile,
                  activeNav: 'Product',
                  hovering: _hovering,
                  onHover: _setHover,
                  onSetActive: _setActive,
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
                    if (isMobileLocal) {
                      Navigator.pushNamed(ctx, '/search');
                    } else {
                      showSearch(context: ctx, delegate: ProductSearchDelegate());
                    }
                  },
                  navigateToWinter: (ctx) => Navigator.pushNamed(ctx, '/winter'),
                ),

                Padding(
                  padding: EdgeInsets.all(isMobile ? 12 : 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Product top area: image + details
                      LayoutBuilder(builder: (context, constraints) {
                        final totalWidth = constraints.maxWidth;
                        final isNarrow = totalWidth < 800;
                        return isNarrow
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Image.asset(product.imageUrl, fit: BoxFit.cover, height: 300),
                                  const SizedBox(height: 12),
                                  _buildDetailsSection(product, isMobile),
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(flex: 5, child: Image.asset(product.imageUrl, fit: BoxFit.cover, height: 420)),
                                  const SizedBox(width: 28),
                                  Expanded(flex: 5, child: _buildDetailsSection(product, isMobile)),
                                ],
                              );
                      }),

                      const SizedBox(height: 24),
                      // Description
                      const Text(
                        'Description',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Redesigned with a fresh chest logo, our essentials and merchandise are cosy and versatile. Replace this placeholder with real product copy.',
                        style: TextStyle(color: Colors.black87),
                      ),
                      const SizedBox(height: 24),
                      // Back to collection button
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: isMobile ? 8 : 12),
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              if (product == null) return;
                              final route = _collectionRouteForProduct(product);
                              Navigator.pushNamed(context, route);
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: const Color(0xFF4d2963)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text('BACK TO COLLECTION', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const CustomFooter(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // slide-down mobile menu
          if (_mobileMenuOpen)
            Positioned(
              top: headerHeight,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                constraints: BoxConstraints(maxHeight: remainingHeight),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2))],
                ),
                child: SingleChildScrollView(child: _drawerContent(context, showTopIcons: false)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection(Product product, bool isMobile) {
    // Updated layout: title, original + sale price, tax note, compact option selectors, outlined ADD TO CART, share buttons
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(product.title, style: TextStyle(fontSize: isMobile ? 20 : 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),

        // prices row
        Row(
          children: [
            if (product.original != null && product.original!.trim().isNotEmpty && product.original != product.price)
              Text(product.original!, style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)),
            const SizedBox(width: 8),
            Text(product.price, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
          ],
        ),
        const SizedBox(height: 6),
        const Text('Tax included.', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 18),

        // Option selectors: Color / Size (optional) / Quantity
        Row(
          children: [
            // Color selector (shared for all products)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Color', style: TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    value: _selectedColor,
                    items: ['Black', 'White', 'Purple', 'Grey', 'Navy'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (v) => setState(() => _selectedColor = v ?? _selectedColor),
                    decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Size selector: only show for non-merchandise (clothing/essentials/winter)
            if (!_isMerchandise(product)) ...[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Size', style: TextStyle(color: Colors.grey, fontSize: 13)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: _selectedSize,
                      items: ['S', 'M', 'L', 'XL'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (v) => setState(() => _selectedSize = v ?? _selectedSize),
                      decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
            ],

            // Quantity
            SizedBox(
              width: 84,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Quantity', style: TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 6),
                  TextFormField(
                    initialValue: '$_quantity',
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      final n = int.tryParse(v) ?? 1;
                      setState(() => _quantity = n.clamp(1, 99));
                    },
                    decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),

        // outlined add to cart (full width)
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              final size = _isMerchandise(product) ? null : _selectedSize;
              Cart().addProduct(product, color: _selectedColor, size: size, quantity: _quantity);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Added ${product.title} x$_quantity (${_selectedColor}${size != null ? ', $size' : ''}) to cart')),
              );
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: const Color(0xFF4d2963)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('ADD TO CART', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 12),

        // social share row
        Row(
          children: [
            TextButton.icon(onPressed: () {}, icon: const Icon(Icons.facebook, size: 16), label: const Text('SHARE')),
            const SizedBox(width: 8),
            TextButton.icon(onPressed: () {}, icon: const Icon(Icons.travel_explore, size: 16), label: const Text('TWEET')),
            const SizedBox(width: 8),
            TextButton.icon(onPressed: () {}, icon: const Icon(Icons.push_pin, size: 16), label: const Text('PIN IT')),
          ],
        ),
      ],
    );
  }
}
