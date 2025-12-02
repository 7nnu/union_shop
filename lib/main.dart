import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: HomeScreen(),
      initialRoute: '/',
      routes: {'/product': (context) => const ProductPage()},
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activeNav = 'Home';
  final Map<String, bool> _hovering = {};
  bool _mobileMenuOpen = false; // track mobile menu state

  // returns the list content used by both drawer and the slide-down menu
  // NOTE: returns a Column with mainAxisSize.min so the slide-down menu will size to its content
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

    // Column with mainAxisSize.min so it only takes required height; wrap with SingleChildScrollView where scrolling is needed.
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  void _setHover(String name, bool val) {
    setState(() {
      _hovering[name] = val;
    });
  }

  void setActive(String name) {
    setState(() {
      activeNav = name;
    });
  }

  void navigateToHome(BuildContext context) {
    setActive('Home');
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    setActive('Product');
    Navigator.pushNamed(context, '/product');
  }

  void placeholderCallbackForButtons() {
    // placeholder
  }

  Widget _buildDrawer(BuildContext context) {
    // keep for compatibility (side-drawer) but not used when mobile uses slide-down
    return Drawer(child: SafeArea(child: _drawerContent(context)));
  }

  // toggle the in-tree slide-down mobile menu
  void _toggleMobileMenu() {
    setState(() => _mobileMenuOpen = !_mobileMenuOpen);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final headerHeight = isMobile ? 120.0 : 175.0;
    final remainingHeight = MediaQuery.of(context).size.height - headerHeight;

    return Scaffold(
      drawer: null,
      body: Stack(
        children: [
          // main page content
          SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Container(
                  height: headerHeight,
                  color: Colors.white,
                  child: Column(
                    children: [
                      // Top banner
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: isMobile ? 8 : 10, horizontal: isMobile ? 12 : 40),
                        color: const Color(0xFF4d2963),
                        child: const Text(
                          'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Main header
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 50),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final headerIsMobile = constraints.maxWidth < 700;
                              if (headerIsMobile) {
                                // Mobile header: logo + icons + hamburger
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => navigateToHome(context),
                                      child: Image.network(
                                        'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                        height: 35,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(Icons.search, size: 20, color: Colors.black),
                                      onPressed: placeholderCallbackForButtons,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.person_outline, size: 20, color: Colors.black),
                                      onPressed: placeholderCallbackForButtons,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.shopping_bag_outlined, size: 20, color: Colors.black),
                                      onPressed: placeholderCallbackForButtons,
                                    ),
                                    // show menu or X depending on open state, slide-down from beneath header
                                    IconButton(
                                      icon: Icon(_mobileMenuOpen ? Icons.close : Icons.menu, color: Colors.black),
                                      onPressed: _toggleMobileMenu,
                                    ),
                                  ],
                                );
                              }

                              // Desktop header: logo + nav + icons (no hamburger)
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => navigateToHome(context),
                                    // show only the logo image on desktop (no "Union Shop" text)
                                    child: Image.network(
                                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                      height: 35,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  // center nav items
                                  Expanded(
                                    child: LayoutBuilder(
                                      builder: (context, c) {
                                        final useRow = c.maxWidth > 520;
                                        final navItems = <Widget>[
                                          // Home (hover + active)
                                          MouseRegion(
                                            onEnter: (_) => _setHover('Home', true),
                                            onExit: (_) => _setHover('Home', false),
                                            child: SizedBox(
                                              height: 36,
                                              child: TextButton(
                                                onPressed: () => navigateToHome(context),
                                                style: TextButton.styleFrom(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                                  minimumSize: const Size(0, 36),
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                ),
                                                child: Text(
                                                  'Home',
                                                  style: TextStyle(
                                                    decoration: (activeNav == 'Home' || (_hovering['Home'] ?? false)) ? TextDecoration.underline : TextDecoration.none,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Shop (popup)
                                          MouseRegion(
                                            onEnter: (_) => _setHover('Shop', true),
                                            onExit: (_) => _setHover('Shop', false),
                                            child: SizedBox(
                                              height: 36,
                                              child: PopupMenuButton<String>(
                                                onSelected: (v) {
                                                  setActive('Shop');
                                                  placeholderCallbackForButtons();
                                                },
                                                itemBuilder: (_) => const [
                                                  PopupMenuItem(value: 'clothing', child: Text('Clothing')),
                                                  PopupMenuItem(value: 'accessories', child: Text('Accessories')),
                                                  PopupMenuItem(value: 'prints', child: Text('Prints')),
                                                ],
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        'Shop',
                                                        style: TextStyle(
                                                          decoration: (activeNav == 'Shop' || (_hovering['Shop'] ?? false)) ? TextDecoration.underline : TextDecoration.none,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      const Icon(Icons.arrow_drop_down, size: 20, color: Colors.black),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          // The Print Shack (popup)
                                          MouseRegion(
                                            onEnter: (_) => _setHover('The Print Shack', true),
                                            onExit: (_) => _setHover('The Print Shack', false),
                                            child: SizedBox(
                                              height: 36,
                                              child: PopupMenuButton<String>(
                                                onSelected: (v) {
                                                  setActive('The Print Shack');
                                                  placeholderCallbackForButtons();
                                                },
                                                itemBuilder: (_) => const [
                                                  PopupMenuItem(value: 'services', child: Text('Services')),
                                                  PopupMenuItem(value: 'pricing', child: Text('Pricing')),
                                                ],
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        'The Print Shack',
                                                        style: TextStyle(
                                                          decoration: (activeNav == 'The Print Shack' || (_hovering['The Print Shack'] ?? false)) ? TextDecoration.underline : TextDecoration.none,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      const Icon(Icons.arrow_drop_down, size: 20, color: Colors.black),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          // SALE!
                                          MouseRegion(
                                            onEnter: (_) => _setHover('SALE!', true),
                                            onExit: (_) => _setHover('SALE!', false),
                                            child: SizedBox(
                                              height: 36,
                                              child: TextButton(
                                                onPressed: () => setActive('SALE!'),
                                                style: TextButton.styleFrom(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                                  minimumSize: const Size(0, 36),
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                ),
                                                child: Text(
                                                  'SALE!',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    decoration: (activeNav == 'SALE!' || (_hovering['SALE!'] ?? false)) ? TextDecoration.underline : TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          // About
                                          MouseRegion(
                                            onEnter: (_) => _setHover('About', true),
                                            onExit: (_) => _setHover('About', false),
                                            child: SizedBox(
                                              height: 36,
                                              child: TextButton(
                                                onPressed: () => setActive('About'),
                                                style: TextButton.styleFrom(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                                  minimumSize: const Size(0, 36),
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                ),
                                                child: Text(
                                                  'About',
                                                  style: TextStyle(
                                                    decoration: (activeNav == 'About' || (_hovering['About'] ?? false)) ? TextDecoration.underline : TextDecoration.none,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ];

                                        if (useRow) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: navItems.map((w) => Padding(padding: const EdgeInsets.symmetric(horizontal: 6.0), child: w)).toList(),
                                          );
                                        }

                                        // fallback (rare): wrap
                                        return Center(
                                          child: Wrap(
                                            alignment: WrapAlignment.center,
                                            spacing: 12,
                                            runSpacing: 6,
                                            children: navItems,
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  // right-side icons (desktop only)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.search, size: 24, color: Colors.black),
                                        onPressed: placeholderCallbackForButtons,
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.person_outline, size: 24, color: Colors.black),
                                        onPressed: placeholderCallbackForButtons,
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.shopping_bag_outlined, size: 24, color: Colors.black),
                                        onPressed: placeholderCallbackForButtons,
                                      ),
                                      // no menu icon here on desktop
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Hero Section
                SizedBox(
                  height: isMobile ? 320 : 475,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // Background image
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://shop.upsu.net/cdn/shop/files/Signature_T-Shirt_Indigo_Blue_2_2048x.jpg?v=1758290534',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      // Content overlay
                      Positioned(
                        left: isMobile ? 12 : 24,
                        right: isMobile ? 12 : 24,
                        top: isMobile ? 40 : 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Essential Range - Over 20% OFF!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isMobile ? 26 : 65,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: isMobile ? 12 : 16),
                            Text(
                              "Over 20% off our Essential Range. Come and grab yours while stock lasts!",
                              style: TextStyle(
                                fontSize: isMobile ? 14 : 24,
                                color: Colors.white,
                                height: 1.4,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: isMobile ? 20 : 32),
                            ElevatedButton(
                              onPressed: placeholderCallbackForButtons,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4d2963),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: isMobile ? 12 : 24),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              child: const Text(
                                'BROWSE COLLECTION',
                                style: TextStyle(fontSize: 14, letterSpacing: 1, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Products Section
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 16.0 : 40.0),
                    child: Column(
                      children: [
                        Text(
                          'ESSENTIAL RANGE - OVER 20% OFF!',
                          style: TextStyle(
                            fontSize: isMobile ? 18 : 25,
                            color: Colors.black,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: isMobile ? 20 : 48),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: isMobile ? 1 : 2,
                          childAspectRatio: isMobile ? 1.0 : 1.7,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 48,
                          children: const [
                            ProductCard(
                              title: 'Placeholder Product 1',
                              price: '£10.00',
                              imageUrl:
                                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                            ),
                            ProductCard(
                              title: 'Placeholder Product 2',
                              price: '£15.00',
                              imageUrl:
                                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                            ),
                            ProductCard(
                              title: 'Placeholder Product 3',
                              price: '£20.00',
                              imageUrl:
                                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                            ),
                            ProductCard(
                              title: 'Placeholder Product 4',
                              price: '£25.00',
                              imageUrl:
                                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Footer
                Container(
                  width: double.infinity,
                  color: Colors.grey[50],
                  padding: const EdgeInsets.all(24),
                  child: const Text(
                    'Placeholder Footer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // slide-down mobile menu inserted under the navbar, not modal.
          // it does not include the top icons (showTopIcons: false) and does not block header interactions.
          if (_mobileMenuOpen)
            Positioned(
              top: headerHeight,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                // allow the container to size to content up to remainingHeight
                constraints: BoxConstraints(maxHeight: remainingHeight),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2))],
                ),
                child: SingleChildScrollView(
                  // _drawerContent now returns a Column with mainAxisSize.min so the scroll view will only be as tall as needed
                  child: _drawerContent(context, showTopIcons: false),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ProductCard (adjusted to keep aspect ratio on mobile)
class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // keep image square-ish so descriptions aren't crushed
          AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.image_not_supported, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  maxLines: 2,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
