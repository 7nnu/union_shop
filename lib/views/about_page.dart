import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:union_shop/views/custom_header.dart';
import 'package:union_shop/views/custom_footer.dart';
import 'package:union_shop/views/search_page.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String activeNav = 'About';
  final Map<String, bool> _hovering = {};
  bool _mobileMenuOpen = false;

  void _setHover(String name, bool val) => setState(() => _hovering[name] = val);
  void setActive(String name) => setState(() => activeNav = name);
  void _toggleMobileMenu() => setState(() => _mobileMenuOpen = !_mobileMenuOpen);

  void navigateToHome(BuildContext context) {
    setActive('Home');
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    setActive('Product');
    Navigator.pushNamed(context, '/product');
  }

  void navigateToAbout(BuildContext context) {
    // already on about - no-op
  }

  void placeholderCallbackForButtons() {
    // placeholder
  }

  Widget _drawerContent(BuildContext context, {bool showTopIcons = true}) {
    final children = <Widget>[];
    if (showTopIcons) {
      children.add(
        Container(
          color: const Color(0xFF4d2963),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Image.network(
                'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                height: 36,
                errorBuilder: (c, e, s) => const SizedBox(width: 36, height: 36),
              ),
              const Spacer(),
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.all(6),
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: placeholderCallbackForButtons,
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.all(6),
                icon: const Icon(Icons.person_outline, color: Colors.white),
                onPressed: placeholderCallbackForButtons,
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.all(6),
                icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                onPressed: placeholderCallbackForButtons,
              ),
            ],
          ),
        ),
      );
    }

    children.addAll([
      ListTile(title: const Text('Home'), onTap: () { setActive('Home'); Navigator.pop(context); navigateToHome(context); }),
      const Divider(height: 1),
      ExpansionTile(title: const Text('Shop'), children: [
        ListTile(title: const Text('Clothing'), onTap: () { Navigator.pop(context); placeholderCallbackForButtons(); }),
        ListTile(title: const Text('Accessories'), onTap: () { Navigator.pop(context); placeholderCallbackForButtons(); }),
      ]),
      const Divider(height: 1),
      ExpansionTile(title: const Text('The Print Shack'), children: [
        ListTile(title: const Text('Services'), onTap: () { Navigator.pop(context); placeholderCallbackForButtons(); }),
        ListTile(title: const Text('Pricing'), onTap: () { Navigator.pop(context); placeholderCallbackForButtons(); }),
      ]),
      const Divider(height: 1),
      ListTile(title: const Text('SALE!', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)), onTap: () { setActive('SALE!'); Navigator.pop(context); }),
      const Divider(height: 1),
      ListTile(title: const Text('About'), onTap: () { setActive('About'); Navigator.pop(context); }),
      const Divider(height: 1),
      ListTile(title: const Text('UPSU.net'), onTap: () { setActive('UPSU.net'); Navigator.pop(context); }),
    ]);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final headerHeight = isMobile ? 120.0 : 130.0;
    final remainingHeight = MediaQuery.of(context).size.height - headerHeight;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CustomHeader(
                  isMobile: isMobile,
                  activeNav: activeNav,
                  hovering: _hovering,
                  onHover: _setHover,
                  onSetActive: setActive,
                  placeholderCallback: placeholderCallbackForButtons,
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

                // Centered, larger About content
                SizedBox(
                  height: math.max(remainingHeight - 120.0, 520.0),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1000),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Text(
                                'About us',
                                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isMobile ? 28 : 44,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 60.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome to the Union Shop!',
                                    style: TextStyle(color: Colors.black87, fontSize: isMobile ? 16 : 20),
                                  ),
                                  const SizedBox(height: 14),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.black87, height: 1.6, fontSize: isMobile ? 15 : 18),
                                      children: [
                                        const TextSpan(text: 'We’re dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive '),
                                        TextSpan(
                                          text: 'personalisation service!',
                                          style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w700, fontSize: isMobile ? 15 : 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text('All online purchases are available for delivery or instore collection!', style: TextStyle(color: Colors.black87, fontSize: isMobile ? 15 : 18)),
                                  const SizedBox(height: 12),
                                  Text('We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don’t hesitate to contact us at hello@upsu.net.', style: TextStyle(color: Colors.black87, fontSize: isMobile ? 15 : 18)),
                                  const SizedBox(height: 12),
                                  Text('Happy shopping!', style: TextStyle(color: Colors.black87, fontSize: isMobile ? 15 : 18)),
                                  const SizedBox(height: 8),
                                  Text('The Union Shop & Reception Team', style: TextStyle(color: Colors.black87, fontSize: isMobile ? 15 : 18)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const CustomFooter(),
              ],
            ),
          ),

          // mobile slide-down menu
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
                child: SingleChildScrollView(
                  child: _drawerContent(context, showTopIcons: false),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
