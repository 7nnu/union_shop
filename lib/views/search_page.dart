import 'package:flutter/material.dart';
import 'package:union_shop/data/products.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/views/product_tile.dart';
import 'package:union_shop/views/custom_header.dart';
import 'package:union_shop/views/custom_footer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<Product> _results = sampleAllProducts;

  // header state for CustomHeader
  final Map<String, bool> _hovering = {};
  bool _mobileMenuOpen = false;

  void _setHover(String name, bool val) => setState(() => _hovering[name] = val);
  void _toggleMobileMenu() => setState(() => _mobileMenuOpen = !_mobileMenuOpen);

  void _update(String q) {
    final query = q.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _results = sampleAllProducts;
      } else {
        _results = sampleAllProducts.where((p) => p.title.toLowerCase().contains(query)).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // If this page was pushed with an initial query (Navigator.pushNamed(..., arguments: 'query')),
    // pick it up after the first frame and update the controller/results so the page shows results.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg is String && arg.trim().isNotEmpty) {
        _controller.text = arg;
        _update(arg);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
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
              if (isMobileLocal) {
                // focus local search field
                _focusNode.requestFocus();
              } else {
                showSearch(context: context, delegate: ProductSearchDelegate());
              }
            },
          ),
          IconButton(visualDensity: VisualDensity.compact, padding: const EdgeInsets.all(6), icon: const Icon(Icons.person_outline, color: Colors.white), onPressed: () { if (showTopIcons) Navigator.pop(context); Navigator.pushNamed(context, '/login'); }),
          IconButton(visualDensity: VisualDensity.compact, padding: const EdgeInsets.all(6), icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white), onPressed: () { if (showTopIcons) Navigator.pop(context); Navigator.pushNamed(context, '/cart'); }),
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

  Widget _buildResults(BuildContext context) {
    if (_results.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(child: Text('No results')),
      );
    }
    final isMobile = MediaQuery.of(context).size.width < 700;
    // responsive item width
    final itemWidth = isMobile ? double.infinity : 320.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: _results.map((p) => SizedBox(width: itemWidth, child: ProductTile(product: p))).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final headerHeight = isMobile ? 120.0 : 130.0;
    final remainingHeight = MediaQuery.of(context).size.height - headerHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: null,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomHeader(
                  isMobile: isMobile,
                  activeNav: 'Search',
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
                    final isM = MediaQuery.of(ctx).size.width < 700;
                    if (isM) {
                      // focus the inline search field on mobile header action
                      _focusNode.requestFocus();
                    } else {
                      showSearch(context: ctx, delegate: ProductSearchDelegate());
                    }
                  },
                  navigateToWinter: (ctx) => Navigator.pushNamed(ctx, '/winter'),
                ),

                // in-page search box (visually replaces the AppBar title field)
                Padding(
                  padding: EdgeInsets.all(isMobile ? 12 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Search products',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              if (_controller.text.isEmpty) {
                                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                                return;
                              }
                              _controller.clear();
                              _update('');
                            },
                          ),
                        ),
                        onChanged: _update,
                        onSubmitted: (_) => _update(_controller.text),
                      ),
                      const SizedBox(height: 12),
                      _buildResults(context),
                    ],
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
                decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2))]),
                child: SingleChildScrollView(child: _drawerContent(context, showTopIcons: false)),
              ),
            ),
        ],
      ),
    );
  }
}

// Desktop SearchDelegate
class ProductSearchDelegate extends SearchDelegate<Product?> {
  final List<Product> products = sampleAllProducts;

  List<Product> _search(String q) {
    final query = q.trim().toLowerCase();
    if (query.isEmpty) return products;
    return products.where((p) => p.title.toLowerCase().contains(query)).toList();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _search(query);
    final isMobile = MediaQuery.of(context).size.width < 700;

    // Desktop: show the styled header, search box and list. For small widths fall back to simpler list.
    if (isMobile) {
      if (results.isEmpty) return const Center(child: Text('No results'));
      return ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: results.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (ctx, i) {
          final p = results[i];
          return ListTile(
            leading: SizedBox(width: 56, height: 56, child: Image.asset(p.imageUrl, fit: BoxFit.cover)),
            title: Text(p.title),
            subtitle: const SizedBox.shrink(),
            trailing: Text(p.price, style: const TextStyle(fontWeight: FontWeight.bold)),
            onTap: () => close(context, p),
          );
        },
      );
    }

    // Desktop layout
    final resultsCount = results.length;
    final heading = resultsCount == 1 ? '1 RESULT' : '$resultsCount RESULTS';
    final controller = TextEditingController(text: query);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 18),
        // Heading centered
        Center(
          child: Text(
            '$heading FOR "${query.toUpperCase()}"',
            style: const TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),

        // search box centered
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (v) {
                      query = v;
                      showResults(context);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      query = controller.text;
                      showResults(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4d2963),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(color: Colors.white)
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text('SUBMIT', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // results list
        Expanded(
          child: results.isEmpty
              ? const Center(child: Text('No results'))
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  itemCount: results.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (ctx, i) {
                    final p = results[i];
                    // price column with optional original (struck) and current price
                    Widget priceColumn() {
                      final original = (p.original ?? '').trim();
                      if (original.isNotEmpty && original != p.price) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(original, style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)),
                            const SizedBox(height: 6),
                            Text(p.price, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        );
                      }
                      return Text(p.price, style: const TextStyle(fontWeight: FontWeight.bold));
                    }

                    return InkWell(
                      onTap: () => close(context, p),
                      child: SizedBox(
                        height: 84,
                        child: Row(
                          children: [
                            // thumbnail
                            SizedBox(
                              width: 72,
                              height: 72,
                              child: Image.asset(p.imageUrl, fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 20),
                            // title (expanded)
                            Expanded(
                              child: Text(p.title, style: const TextStyle(fontSize: 16)),
                            ),
                            // price column
                            SizedBox(width: 140, child: priceColumn()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = _search(query);
    return ListView(
      padding: const EdgeInsets.all(12),
      children: suggestions
          .map(
            (p) => ListTile(
              title: Text(p.title),
              onTap: () {
                query = p.title;
                showResults(context);
              },
            ),
          )
          .toList(),
    );
  }
}
