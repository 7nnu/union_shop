import 'package:flutter/material.dart';
import 'package:union_shop/data/products.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/views/product_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Product> _results = sampleAllProducts;

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
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search products',
            border: InputBorder.none,
          ),
          onChanged: _update,
        ),
        backgroundColor: const Color(0xFF4d2963),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              if (_controller.text.isEmpty) {
                // no query — return to home screen
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                return;
              }
              // has query — clear it
              _controller.clear();
              _update('');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 12 : 20),
        child: _buildResults(context),
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
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4d2963)),
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
