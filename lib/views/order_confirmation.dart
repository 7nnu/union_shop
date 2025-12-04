import 'package:flutter/material.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/views/custom_header.dart';
import 'package:union_shop/views/custom_footer.dart';
import 'package:union_shop/views/search_page.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final List<CartItem> items = args is List<CartItem> ? args : [];

    final isMobile = MediaQuery.of(context).size.width < 700;
    final headerHeight = isMobile ? 120.0 : 130.0;
    final remainingHeight = MediaQuery.of(context).size.height - headerHeight;

    final subtotal = items.fold<double>(0.0, (s, it) => s + it.totalPrice);

    return Scaffold(
      drawer: null,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CustomHeader(
                  isMobile: isMobile,
                  activeNav: 'Order',
                  hovering: const {},
                  onHover: (name, val) {},
                  onSetActive: (s) {},
                  placeholderCallback: () => Navigator.pushNamed(context, '/login'),
                  toggleMobileMenu: () {},
                  mobileMenuOpen: false,
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
                      const SizedBox(height: 8),
                      Text('Order Number 0000', textAlign: TextAlign.center, style: TextStyle(fontSize: isMobile ? 22 : 28, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 18),
                      Text('Thank you for your order! Here is a summary of what you purchased:', textAlign: TextAlign.center, style: const TextStyle(color: Colors.black87)),
                      const SizedBox(height: 18),

                      if (items.isEmpty)
                        Center(child: Text('No items in order', style: TextStyle(color: Colors.grey.shade700)))
                      else
                        Column(
                          children: items.map((it) {
                            return ListTile(
                              leading: SizedBox(width: 56, height: 56, child: Image.asset(it.product.imageUrl, fit: BoxFit.cover)),
                              title: Text(it.product.title),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Color: ${it.color}${it.size != null ? ' · Size: ${it.size}' : ''}'),
                                  if (it.personalisationLine1 != null && it.personalisationLine1!.isNotEmpty) Text('Line 1: ${it.personalisationLine1}'),
                                  if (it.personalisationLine2 != null && it.personalisationLine2!.isNotEmpty) Text('Line 2: ${it.personalisationLine2}'),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('x${it.quantity}'),
                                  const SizedBox(height: 6),
                                  Text('£${it.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            );
                          }).toList(),
                        ),

                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('£${subtotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),

                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false),
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4d2963), padding: const EdgeInsets.symmetric(vertical: 14)),
                        child: const Text('RETURN TO HOME', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),

                      const SizedBox(height: 24),
                      const CustomFooter(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // no mobile menu here (kept simple)
        ],
      ),
    );
  }
}
