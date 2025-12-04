import 'package:flutter/material.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:union_shop/views/about_page.dart';
import 'package:union_shop/views/custom_header.dart';
import 'package:union_shop/views/custom_footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/data/products.dart';
import 'package:union_shop/views/product_tile.dart';
import 'package:union_shop/views/login_page.dart';
import 'package:union_shop/views/clothing_collection.dart';
import 'package:union_shop/views/essentials_collection.dart';
import 'package:union_shop/views/search_page.dart';
import 'package:union_shop/views/winter_collection.dart';
import 'package:union_shop/views/merchandise_collection.dart';
import 'package:union_shop/views/all_collection.dart';
import 'package:union_shop/views/sale_collection.dart';
import 'package:union_shop/views/collections_overview.dart';
import 'package:union_shop/views/cart_page.dart';

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
      routes: {
        '/product': (context) => const ProductPage(),
        '/about': (context) => const AboutPage(),
        '/login': (context) => const LoginPage(),
        '/cart': (context) => const CartPage(),
        '/clothing': (context) => const ClothingCollectionPage(),
        '/essentials': (context) => const EssentialsCollectionPage(),
        '/merchandise': (context) => const MerchandiseCollectionPage(),
        '/sale': (context) => const SaleCollectionPage(),
        '/winter': (context) => const WinterCollectionPage(),
        '/all': (context) => const AllCollectionPage(),
        '/collections': (context) => const CollectionsOverviewPage(),
        '/search': (context) => const SearchPage(),
      },
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
                onPressed: () => navigateToSearch(context),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.all(6),
                icon: const Icon(Icons.person_outline, color: Colors.white),
                onPressed: () => navigateToLogin(context),
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
        ListTile(title: const Text('Clothing'), onTap: () { Navigator.pop(context); navigateToClothing(context); }),
        ListTile(title: const Text('Merchandise'), onTap: () { Navigator.pop(context); navigateToMerchandise(context); }),
        ListTile(title: const Text('Essentials'), onTap: () { Navigator.pop(context); navigateToEssentials(context); }),
        ListTile(title: const Text('Winter'), onTap: () { Navigator.pop(context); navigateToWinter(context); }),
        ListTile(title: const Text('All'), onTap: () { Navigator.pop(context); navigateToAll(context); }),
      ]),
      const Divider(height: 1),
      ExpansionTile(title: const Text('The Print Shack'), children: [
        ListTile(title: const Text('About'), onTap: () { Navigator.pop(context); placeholderCallbackForButtons(); }),
        ListTile(title: const Text('Personalisation'), onTap: () { Navigator.pop(context); placeholderCallbackForButtons(); }),
      ]),
      const Divider(height: 1),
      ListTile(title: const Text('SALE!', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), onTap: () { setActive('SALE!'); Navigator.pop(context); }),
      const Divider(height: 1),
      ListTile(title: const Text('About'), onTap: () { setActive('About'); Navigator.pop(context); navigateToAbout(context); }),
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

  void navigateToAbout(BuildContext context) {
    setActive('About');
    Navigator.pushNamed(context, '/about');
  }

  void placeholderCallbackForButtons() {
    // default placeholder now navigates to login (header's profile button uses this)
    navigateToLogin(context);
  }

  void navigateToLogin(BuildContext context) {
    setActive('Login');
    Navigator.pushNamed(context, '/login');
  }

  void navigateToClothing(BuildContext context) {
    setActive('Clothing');
    Navigator.pushNamed(context, '/clothing');
  }

  void navigateToEssentials(BuildContext context) {
    setActive('Essentials');
    Navigator.pushNamed(context, '/essentials');
  }

  Future<void> navigateToSearch(BuildContext context) async {
    final isMobile = MediaQuery.of(context).size.width < 700;
    if (isMobile) {
      Navigator.pushNamed(context, '/search');
      return;
    }

    // Desktop: show SearchDelegate and navigate to product page if a product is selected.
    final result = await showSearch<Product?>(context: context, delegate: ProductSearchDelegate());
    if (result != null) {
      Navigator.pushNamed(context, '/product', arguments: result);
    }
  }

  void navigateToWinter(BuildContext context) {
    setActive('Winter');
    Navigator.pushNamed(context, '/winter');
  }

  void navigateToMerchandise(BuildContext context) {
    setActive('Merchandise');
    Navigator.pushNamed(context, '/merchandise');
  }

  void navigateToAll(BuildContext context) {
    setActive('All');
    Navigator.pushNamed(context, '/all');
  }

  void navigateToSale(BuildContext context) {
    setActive('SALE!');
    Navigator.pushNamed(context, '/sale');
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
      drawer: _buildDrawer(context),
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
                  navigateToAbout: navigateToAbout,
                  navigateToClothing: navigateToClothing,
                  navigateToEssentials: navigateToEssentials,
                  navigateToMerchandise: navigateToMerchandise,
                  navigateToSale: navigateToSale,
                  navigateToSearch: navigateToSearch,
                  navigateToWinter: navigateToWinter,
                  navigateToAll: navigateToAll,
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
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/images/tshirt.png'),
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
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: isMobile ? 12 : 24,
                            right: isMobile ? 12 : 24,
                            top: isMobile ? 40 : 80,
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  // ensure overlay cannot grow beyond the hero height
                                  maxHeight: isMobile ? 280 : 420,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
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
                                      onPressed: () => navigateToEssentials(context),
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
                            ),
                          ),
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
                        // Center the product area and constrain its maximum width so two columns
                        // align like the provided screenshot. Item widths are computed from the
                        // constrained content width to avoid odd gaps.
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final totalWidth = constraints.maxWidth;
                            const maxContentWidth = 1100.0; // adjust to taste to match screenshot
                            final contentWidth = totalWidth > maxContentWidth ? maxContentWidth : totalWidth;

                            final spacing = isMobile ? 16.0 : 20.0;
                            final runSpacing = isMobile ? 20.0 : 20.0;

                            // For mobile use a single column, otherwise two columns.
                            final columns = isMobile ? 1 : 2;
                            final itemWidth = (contentWidth - (spacing * (columns - 1))) / columns;

                            return Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: maxContentWidth),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  spacing: spacing,
                                  runSpacing: runSpacing,
                                  children: sampleEssentialsHome
                                      .map((prod) => SizedBox(width: itemWidth, child: ProductTile(product: prod)))
                                      .toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),


                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 16.0 : 40.0),
                    child: Column(
                      children: [
                        Text(
                          'MERCHANDISE COLLECTION!',
                          style: TextStyle(
                            fontSize: isMobile ? 18 : 25,
                            color: Colors.black,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: isMobile ? 20 : 48),
                        // Center the product area and constrain its maximum width so two columns
                        // align like the provided screenshot. Item widths are computed from the
                        // constrained content width to avoid odd gaps.
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final totalWidth = constraints.maxWidth;
                            const maxContentWidth = 1100.0; // adjust to taste to match screenshot
                            final contentWidth = totalWidth > maxContentWidth ? maxContentWidth : totalWidth;

                            final spacing = isMobile ? 16.0 : 20.0;
                            final runSpacing = isMobile ? 20.0 : 20.0;

                            // For mobile use a single column, otherwise two columns.
                            final columns = isMobile ? 1 : 2;
                            final itemWidth = (contentWidth - (spacing * (columns - 1))) / columns;

                            return Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: maxContentWidth),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  spacing: spacing,
                                  runSpacing: runSpacing,
                                  children: sampleMerchandiseHome
                                      .map((prod) => SizedBox(width: itemWidth, child: ProductTile(product: prod)))
                                      .toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),


                // "View All Collections" CTA -> opens overview page
                Padding(
                  padding: EdgeInsets.symmetric(vertical: isMobile ? 18.0 : 28.0),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/collections'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: isMobile ? 14 : 18),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          ),
                          child: Text(
                            'VIEW ALL COLLECTIONS',
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
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
