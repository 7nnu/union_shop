import 'package:flutter/material.dart';
import 'package:union_shop/data/products.dart';
import 'package:union_shop/views/custom_header.dart';
import 'package:union_shop/views/custom_footer.dart';
import 'package:union_shop/views/search_page.dart';

class CollectionsOverviewPage extends StatefulWidget {
  const CollectionsOverviewPage({super.key});

  @override
  State<CollectionsOverviewPage> createState() => _CollectionsOverviewPageState();
}

class _CollectionsOverviewPageState extends State<CollectionsOverviewPage> {
  final Map<String, bool> _hovering = {};
  bool _mobileMenuOpen = false;

  void _setHover(String name, bool val) => setState(() => _hovering[name] = val);
  void _setActive(String name) => setState(() { /* optional */ });
  void _toggleMobileMenu() => setState(() => _mobileMenuOpen = !_mobileMenuOpen);

  Widget _drawerContent(BuildContext context, {bool showTopIcons = true}) {
    final children = <Widget>[];
    if (showTopIcons) {
      children.add(Container(
        color: const Color(0xFF4d2963),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(children: [
          Image.network('https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854', height: 36, errorBuilder: (c,e,s)=> const SizedBox(width:36,height:36)),
        ]),
      ));
    }
    children.addAll([
      ListTile(title: const Text('Home'), onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false)),
    ]);
    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
  }

  Widget _buildTile(String title, String route, String imageAsset) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: AspectRatio(
        aspectRatio: 4/3,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(imageAsset, fit: BoxFit.cover),
            Container(color: Colors.black26),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, route),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4d2963)),
                    child: const Text('VIEW COLLECTION'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final headerHeight = isMobile ? 120.0 : 130.0;
    final remainingHeight = MediaQuery.of(context).size.height - headerHeight;

    // pick example product images (fall back to an empty placeholder if missing)
    final clothingImg = sampleClothingProducts.isNotEmpty ? sampleClothingProducts[0].imageUrl : 'assets/images/hoodie.png';
    final merchImg = sampleMerchandiseProducts.isNotEmpty ? sampleMerchandiseProducts[0].imageUrl : 'assets/images/tote_bag.png';
    final essentialsImg = sampleEssentialProducts.isNotEmpty ? sampleEssentialProducts[0].imageUrl : 'assets/images/hoodie.png';
    final winterImg = sampleWinterProducts.isNotEmpty ? sampleWinterProducts[0].imageUrl : 'assets/images/scarf.png';
    final allImg = sampleAllProducts.isNotEmpty ? sampleAllProducts[0].imageUrl : 'assets/images/hoodie.png';
    final saleImg = sampleSaleProducts.isNotEmpty ? sampleSaleProducts[0].imageUrl : 'assets/images/pink_beanie.png';

    return Scaffold(
      drawer: null,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CustomHeader(
                  isMobile: isMobile,
                  activeNav: 'Collections',
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
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        child: Text('Collections', textAlign: TextAlign.center, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      ),

                      // grid of collection tiles — choose columns by available width so images sit side-by-side
                      LayoutBuilder(builder: (context, constraints) {
                        final totalWidth = constraints.maxWidth;
                        final spacing = 16.0;
                        // responsive columns: 1 on mobile, 3 on wide screens, 2 otherwise
                        final columns = totalWidth > 1100 ? 3 : (totalWidth > 700 ? 2 : 1);
                        final itemWidth = (totalWidth - (spacing * (columns - 1))) / columns;

                        return Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1200),
                            child: Wrap(
                              spacing: spacing,
                              runSpacing: spacing,
                              children: [
                                SizedBox(width: itemWidth, child: _buildTile('Clothing', '/clothing', clothingImg)),
                                SizedBox(width: itemWidth, child: _buildTile('Merchandise', '/merchandise', merchImg)),
                                SizedBox(width: itemWidth, child: _buildTile('Essentials', '/essentials', essentialsImg)),
                                SizedBox(width: itemWidth, child: _buildTile('Winter', '/winter', winterImg)),
                                SizedBox(width: itemWidth, child: _buildTile('All Products', '/all', allImg)),
                                SizedBox(width: itemWidth, child: _buildTile('Sale', '/sale', saleImg)),
                              ],
                            ),
                          ),
                        );
                      }),

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
