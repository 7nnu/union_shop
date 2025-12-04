import 'package:flutter/material.dart';
import 'package:union_shop/views/custom_header.dart';
import 'package:union_shop/views/custom_footer.dart';
import 'package:union_shop/views/search_page.dart';

class PrintShackAboutPage extends StatefulWidget {
  const PrintShackAboutPage({super.key});

  @override
  State<PrintShackAboutPage> createState() => _PrintShackAboutPageState();
}

class _PrintShackAboutPageState extends State<PrintShackAboutPage> {
  final Map<String, bool> _hovering = {};
  bool _mobileMenuOpen = false;

  void _setHover(String name, bool val) => setState(() => _hovering[name] = val);
  void _setActive(String name) => setState(() { /* optional visual state */ });
  void _toggleMobileMenu() => setState(() => _mobileMenuOpen = !_mobileMenuOpen);

  Widget _drawerContent(BuildContext context, {bool showTopIcons = true}) {
    final children = <Widget>[];
    if (showTopIcons) {
      children.add(Container(
        color: const Color(0xFF4d2963),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Image.network('https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854', height: 36, errorBuilder: (c,e,s)=> const SizedBox(width:36,height:36)),
          ],
        ),
      ));
    }
    children.addAll([
      ListTile(title: const Text('Home'), onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false)),
    ]);
    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final headerHeight = isMobile ? 120.0 : 130.0;
    final remainingHeight = MediaQuery.of(context).size.height - headerHeight;

    // The text content (no images)
    final titleStyle = TextStyle(fontSize: isMobile ? 20 : 28, fontWeight: FontWeight.bold);
    final headingStyle = TextStyle(fontSize: isMobile ? 14 : 16, fontWeight: FontWeight.bold);
    final bodyStyle = TextStyle(fontSize: isMobile ? 13 : 15, color: Colors.black87, height: 1.4);

    return Scaffold(
      drawer: null,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CustomHeader(
                  isMobile: isMobile,
                  activeNav: 'The Print Shack',
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
                  padding: EdgeInsets.all(isMobile ? 16 : 32),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(child: Text('The Union Print Shack', style: titleStyle)),
                        const SizedBox(height: 20),

                        Center(child: Text('Make It Yours at The Union Print Shack', style: headingStyle)),
                        const SizedBox(height: 8),
                        Text(
                          "Want to add a personal touch? We've got you covered with heat-pressed customisation on all our clothing. Swing by the shop - our team's always happy to help you pick the right gear and answer any questions.",
                          style: bodyStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        Center(child: Text('Uni Gear or Your Gear - We’ll Personalise It', style: headingStyle)),
                        const SizedBox(height: 8),
                        Text(
                          "Whether you're repping your university or putting your own spin on a hoodie you already own, we've got you covered. We can personalise official uni-branded clothing and your own items - just bring them in and let's get creative!",
                          style: bodyStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        Center(child: Text('Simple Pricing, No Surprises', style: headingStyle)),
                        const SizedBox(height: 8),
                        Text(
                          "Customising your gear won't break the bank - just £3 for one line of text or a small chest logo, and £5 for two lines or a large back logo. Turnaround time is up to three working days, and we'll let you know as soon as it's ready to collect.",
                          style: bodyStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        Center(child: Text('Personalisation Terms & Conditions', style: headingStyle)),
                        const SizedBox(height: 8),
                        Text(
                          "We will print your clothing exactly as you have provided it to us, whether online or in person. We are not responsible for any spelling errors. Please ensure your chosen text is clearly displayed in either capitals or lowercase. Refunds are not provided for any personalised items.",
                          style: bodyStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        Center(child: Text('Ready to Make It Yours?', style: headingStyle)),
                        const SizedBox(height: 8),
                        Text(
                          "Pop in or get in touch today - let's create something uniquely you with our personalisation service - The Union Print Shack!",
                          style: bodyStyle,
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 28),
                        const CustomFooter(),
                      ],
                    ),
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
