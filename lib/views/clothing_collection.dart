import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/data/products.dart';
import 'package:union_shop/views/product_tile.dart';
import 'package:union_shop/views/custom_header.dart';
import 'package:union_shop/views/custom_footer.dart';
import 'package:union_shop/views/search_page.dart';

class ClothingCollectionPage extends StatefulWidget {
  const ClothingCollectionPage({super.key});

  @override
  State<ClothingCollectionPage> createState() => _ClothingCollectionPageState();
}

class _ClothingCollectionPageState extends State<ClothingCollectionPage> {
  String _filter = 'All products';
  String _sort = 'Featured';

  // header state
  String activeNav = 'Clothing';
  final Map<String, bool> _hovering = {};
  bool _mobileMenuOpen = false;

  void _setHover(String name, bool val) => setState(() => _hovering[name] = val);
  void _setActive(String name) => setState(() => activeNav = name);
  void _toggleMobileMenu() => setState(() => _mobileMenuOpen = !_mobileMenuOpen);

  void _navigateToHome() => Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
  void _navigateToProduct() => Navigator.pushNamed(context, '/product');
  void _navigateToAbout() => Navigator.pushNamed(context, '/about');
  void _navigateToLogin() => Navigator.pushNamed(context, '/login');

  final List<String> _filters = [
    'All products',
    'Hoodies',
    'T-Shirts',
    'Jackets',
    'Sale',
  ];

  final List<String> _sorts = [
    'Featured',
    'Price: Low to High',
    'Price: High to Low',
  ];

  double _priceValue(Product p) {
    final s = p.price.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(s) ?? double.maxFinite;
  }

  List<Product> _computeList() {
    List<Product> list = sampleClothingProducts.toList();

    if (_filter == 'Sale') {
      list = sampleClothingProducts.toList();
    } else if (_filter == 'Hoodies') {
      list = list.where((p) => p.title.toLowerCase().contains('hoodie')).toList();
    } else if (_filter == 'T-Shirts') {
      list = list.where((p) => p.title.toLowerCase().contains('t-shirt') || p.title.toLowerCase().contains('tshirt')).toList();
    } else if (_filter == 'Jackets') {
      list = list.where((p) => p.title.toLowerCase().contains('jacket')).toList();
    } // 'All products' keeps the full clothing list

    if (_sort == 'Price: Low to High') {
      list.sort((a, b) => _priceValue(a).compareTo(_priceValue(b)));
    } else if (_sort == 'Price: High to Low') {
      list.sort((a, b) => _priceValue(b).compareTo(_priceValue(a)));
    }
    return list;
  }

  // minimal drawer content used for slide-down on mobile
  Widget _drawerContent(BuildContext context, {bool showTopIcons = true}) {
    final children = <Widget>[];
    if (showTopIcons) {
      children.add(Container(
        color: const Color(0xFF4d2963),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Image.network('https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854', height: 36, errorBuilder: (c,e,s)=> const SizedBox(width:36,height:36)),
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
          ],
        ),
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
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final products = _computeList();
    // compact styles for mobile filter/sort bar
    final labelStyle = TextStyle(fontSize: isMobile ? 10 : 12, color: Colors.grey);
    final dropdownTextStyle = TextStyle(fontSize: isMobile ? 12 : 14, color: Colors.black);
    final dropdownIconSize = isMobile ? 18.0 : 24.0;
    final smallGap = isMobile ? 8.0 : 24.0;

    final headerHeight = isMobile ? 120.0 : 130.0;
    final remainingHeight = MediaQuery.of(context).size.height - headerHeight;

    // Render header, collection content and footer with slide-down mobile menu
    return Scaffold(
      drawer: null,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // main content
          SingleChildScrollView(
            child: Column(
              children: [
                CustomHeader(
                  isMobile: isMobile,
                  activeNav: activeNav,
                  hovering: _hovering,
                  onHover: _setHover,
                  onSetActive: _setActive,
                  placeholderCallback: _navigateToLogin,
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

                // page content
                Padding(
                  padding: EdgeInsets.all(isMobile ? 12 : 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Heading
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Text('Clothing', textAlign: TextAlign.center, style: TextStyle(fontSize: isMobile ? 22 : 34, fontWeight: FontWeight.bold)),
                      ),

                      // Filter / Sort bar
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                        ),
                        child: Row(
                          children: [
                            // Filter
                            Text('FILTER BY', style: labelStyle),
                            SizedBox(width: 8),
                            DropdownButton<String>(
                              value: _filter,
                              style: dropdownTextStyle,
                              iconSize: dropdownIconSize,
                              isDense: true,
                              items: _filters.map((f) => DropdownMenuItem(value: f, child: Text(f, style: dropdownTextStyle))).toList(),
                              onChanged: (v) => setState(() => _filter = v ?? _filter),
                            ),
                            SizedBox(width: smallGap),
                            // Sort
                            Text('SORT BY', style: labelStyle),
                            SizedBox(width: 8),
                            DropdownButton<String>(
                              value: _sort,
                              style: dropdownTextStyle,
                              iconSize: dropdownIconSize,
                              isDense: true,
                              items: _sorts.map((s) => DropdownMenuItem(value: s, child: Text(s, style: dropdownTextStyle))).toList(),
                              onChanged: (v) => setState(() => _sort = v ?? _sort),
                            ),
                            const Spacer(),
                            isMobile ? const SizedBox.shrink() : Text('${products.length} products', style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Product grid (responsive)
                      LayoutBuilder(builder: (context, constraints) {
                        final totalWidth = constraints.maxWidth;
                        const maxContentWidth = 1200.0;
                        final contentWidth = totalWidth > maxContentWidth ? maxContentWidth : totalWidth;
                        final spacing = isMobile ? 12.0 : 20.0;
                        final runSpacing = isMobile ? 12.0 : 20.0;
                        final columns = isMobile ? 1 : 3;
                        final itemWidth = (contentWidth - (spacing * (columns - 1))) / columns;

                        return Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: maxContentWidth),
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              spacing: spacing,
                              runSpacing: runSpacing,
                              children: products
                                  .map((p) => SizedBox(
                                        width: itemWidth,
                                        child: ProductTile(product: p),
                                      ))
                                  .toList(),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                const CustomFooter(),
              ],
            ),
          ),

          // slide-down mobile menu inserted under the navbar
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
