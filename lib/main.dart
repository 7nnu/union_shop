import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/views/custom_header.dart';
import 'package:union_shop/views/custom_footer.dart';

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
    // match CustomHeader's desktop height (shorter)
    final headerHeight = isMobile ? 120.0 : 130.0;
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
                CustomHeader(
                  isMobile: isMobile,
                  activeNav: activeNav,
                  hovering: _hovering,
                  onHover: _setHover,
                  onSetActive: setActive,
                  placeholderCallback: placeholderCallbackForButtons,
                  toggleMobileMenu: _toggleMobileMenu,
                  mobileMenuOpen: _mobileMenuOpen,
                  navigateToHome: navigateToHome,
                  navigateToProduct: navigateToProduct,
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
                const CustomFooter(),
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
