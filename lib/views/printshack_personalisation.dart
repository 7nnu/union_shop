import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/views/custom_header.dart';
import 'package:union_shop/views/custom_footer.dart';
import 'package:union_shop/views/search_page.dart';

class PrintShackPersonalisationPage extends StatefulWidget {
  const PrintShackPersonalisationPage({super.key});

  @override
  State<PrintShackPersonalisationPage> createState() => _PrintShackPersonalisationPageState();
}

class _PrintShackPersonalisationPageState extends State<PrintShackPersonalisationPage> {
  String _linesOption = 'One Line of Text';
  final TextEditingController _line1Controller = TextEditingController();
  final TextEditingController _line2Controller = TextEditingController();
  int _quantity = 1;

  final Map<String, bool> _hovering = {};
  bool _mobileMenuOpen = false;

  void _toggleMobileMenu() => setState(() => _mobileMenuOpen = !_mobileMenuOpen);
  void _setHover(String n, bool v) => setState(() => _hovering[n] = v);

  @override
  void dispose() {
    _line1Controller.dispose();
    _line2Controller.dispose();
    super.dispose();
  }

  // add-to-cart moved to a class method (uses Cart().addProduct like product pages)
  void _addToCart() {
    final l1 = _line1Controller.text.trim();
    final l2 = _line2Controller.text.trim();

    if (_linesOption == 'One Line of Text' && l1.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter text for line 1')));
      return;
    }
    if (_linesOption == 'Two Lines of Text' && (l1.isEmpty && l2.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter text for at least one line')));
      return;
    }

    final line1 = l1.isNotEmpty ? (l1.length > 10 ? l1.substring(0, 10) : l1) : null;
    final line2 = l2.isNotEmpty ? (l2.length > 10 ? l2.substring(0, 10) : l2) : null;

    final price = _linesOption == 'One Line of Text' ? '£3.00' : '£5.00';
    final product = Product(title: 'Personalisation', original: '', price: price, imageUrl: 'assets/images/hoodie.png');

    Cart().addProduct(
      product,
      color: 'N/A',
      size: null,
      quantity: _quantity,
      personalisationLine1: line1,
      personalisationLine2: line2,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added Personalisation x$_quantity${line1 != null ? ' (\"$line1\"' : ''}${line2 != null ? ', \"$line2\"' : ''}) to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final headerHeight = isMobile ? 120.0 : 130.0;
    final remainingHeight = MediaQuery.of(context).size.height - headerHeight;

    // We create a lightweight Product for this personalisation item.
    // Price will be £3 for one line, £5 for two lines (we keep price in product.price for display)
    final basePrice = _linesOption == 'One Line of Text' ? '£3.00' : '£5.00';
    final product = Product(title: 'Personalisation', original: '', price: basePrice, imageUrl: 'assets/images/hoodie.png');

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
                  onSetActive: (s) {},
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
                      Text('Personalisation', style: TextStyle(fontSize: isMobile ? 22 : 32, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),

                      // Image on left (desktop) and options to right
                      LayoutBuilder(builder: (c, cons) {
                        final wide = cons.maxWidth > 800;
                        if (wide) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 5, child: Image.asset('assets/images/hoodie.png', height: 360, fit: BoxFit.cover)),
                              const SizedBox(width: 28),
                              Expanded(flex: 5, child: _buildOptionsSection(isMobile)),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Image.asset('assets/images/hoodie.png', height: 260, fit: BoxFit.cover),
                              const SizedBox(height: 12),
                              _buildOptionsSection(isMobile),
                            ],
                          );
                        }
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

  Widget _buildOptionsSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Per Line:', style: TextStyle(color: Colors.grey.shade700)),
        const SizedBox(height: 8),
        DropdownButton<String>(
          value: _linesOption,
          items: const [
            DropdownMenuItem(value: 'One Line of Text', child: Text('One Line of Text')),
            DropdownMenuItem(value: 'Two Lines of Text', child: Text('Two Lines of Text')),
          ],
          onChanged: (v) => setState(() => _linesOption = v ?? _linesOption),
        ),
        const SizedBox(height: 12),

        const Text('Personalisation Line 1:'),
        const SizedBox(height: 6),
        TextField(
          controller: _line1Controller,
          maxLength: 10,
          decoration: const InputDecoration(border: OutlineInputBorder(), counterText: ''),
        ),
        const SizedBox(height: 12),

        if (_linesOption == 'Two Lines of Text') ...[
          const Text('Personalisation Line 2:'),
          const SizedBox(height: 6),
          TextField(
            controller: _line2Controller,
            maxLength: 10,
            decoration: const InputDecoration(border: OutlineInputBorder(), counterText: ''),
          ),
          const SizedBox(height: 12),
        ],

        const Text('Quantity'),
        const SizedBox(height: 6),
        SizedBox(
          width: 84,
          child: TextFormField(
            initialValue: '1',
            keyboardType: TextInputType.number,
            onChanged: (v) {
              final n = int.tryParse(v) ?? 1;
              setState(() => _quantity = n.clamp(1, 99));
            },
            decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
          ),
        ),
        const SizedBox(height: 14),

        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _addToCart,
            style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF4d2963)), padding: const EdgeInsets.symmetric(vertical: 14)),
            child: const Text('ADD TO CART', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),

        const SizedBox(height: 12),
        Text('£3 for one line of text! £5 for two!', style: TextStyle(color: Colors.grey.shade700)),
        const SizedBox(height: 8),
        Text('One line of text is 10 characters.', style: TextStyle(color: Colors.grey.shade700)),
        const SizedBox(height: 12),
        Text('Please ensure all spellings are correct before submitting your purchase as we will print your item with the exact wording you provide. Personalised items do not qualify for refunds.', style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _drawerContent(BuildContext context, {bool showTopIcons = true}) {
    final children = <Widget>[];
    if (showTopIcons) {
      children.add(Container(
        color: const Color(0xFF4d2963),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(children: [
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
}
