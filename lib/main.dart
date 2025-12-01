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
      // By default, the app starts at the '/' route, which is the HomeScreen
      initialRoute: '/',
      // When navigating to '/product', build and return the ProductPage
      // In your browser, try this link: http://localhost:49856/#/product
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
  String activeNav = 'Home'; // track which nav is active

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
    setActive(''); // clear or set to product if you want
    Navigator.pushNamed(context, '/product');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 175,
              color: Colors.white,
              child: Column(
                children: [
                  // Top banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    color: const Color(0xFF4d2963),
                    child: const Text(
                      'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Main header
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final isMobile = constraints.maxWidth < 700;
                          if (isMobile) {
                            // Mobile: show logo + menu button (opens drawer)
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
                                Builder(
                                  builder: (scaffoldCtx) => IconButton(
                                    icon: const Icon(Icons.menu, color: Colors.black),
                                    onPressed: () => Scaffold.of(scaffoldCtx).openDrawer(),
                                  ),
                                ),
                              ],
                            );
                          }

                          // Desktop / wide: centered horizontal nav with dropdowns
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () => navigateToHome(context),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(
                                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                      height: 35,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                              ),

                              // center nav items: use Row on wide screens so items stay horizontal,
                              // fall back to Wrap when space is limited.
                              Expanded(
                                child: LayoutBuilder(
                                  builder: (context, c) {
                                    final useRow = true; // keep horizontal for now

                                    final navItems = <Widget>[
                                      SizedBox(
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
                                              decoration: activeNav == 'Home' ? TextDecoration.underline : TextDecoration.none,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(
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
                                                    decoration: activeNav == 'Shop' ? TextDecoration.underline : TextDecoration.none,
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

                                      SizedBox(
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
                                                    decoration: activeNav == 'The Print Shack' ? TextDecoration.underline : TextDecoration.none,
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

                                      SizedBox(
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
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              decoration: activeNav == 'SALE!' ? TextDecoration.underline : TextDecoration.none,
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(
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
                                              decoration: activeNav == 'About' ? TextDecoration.underline : TextDecoration.none,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ];

                                    if (useRow) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: navItems
                                            .map((w) => Padding(padding: const EdgeInsets.symmetric(horizontal: 6.0), child: w))
                                            .toList(),
                                      );
                                    }

                                    return const SizedBox.shrink();
                                  },
                                ),
                              ),

                              // right-side icons (optional)
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
              height: 475,
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
                          color: Colors.black.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                  ),
                  // Content overlay
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Essential Range - Over 20% OFF!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 65,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                            fontFamily: '',
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Over 20% off our Essential Range. Come and grab yours while stock lasts!",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: placeholderCallbackForButtons,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    const Text(
                      'EESENTIAL RANGE - OVER 20% OFF!',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 48),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 2 : 1,
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
    );
  }
}

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
          Expanded(
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
          Column(
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
        ],
      ),
    );
  }
}
