import 'package:flutter/material.dart';

class CustomFooter extends StatefulWidget {
  final String text;
  const CustomFooter({super.key, this.text = 'Placeholder Footer'});

  @override
  State<CustomFooter> createState() => _CustomFooterState();
}

class _CustomFooterState extends State<CustomFooter> {
  final TextEditingController _emailController = TextEditingController();

  void _subscribe() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an email')),
      );
      return;
    }

    final lower = email.toLowerCase();
    final allowed = ['@gmail.com', '@myport.ac.uk'];
    final valid = allowed.any((s) => lower.endsWith(s));

    if (!valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an email that ends with @gmail.com or @myport.ac.uk')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Subscribed: $email')),
    );
    _emailController.clear();
  }

  Widget _buildSectionTitle(String title) {
    // smaller bottom gap so section title is closer to content
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _paymentBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      margin: const EdgeInsets.only(left: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top: desktop keeps three columns; mobile shows compact stacked footer (newsletter + social + payments)
          if (!isMobile) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Opening Hours
                Expanded(flex: 3, child: _buildOpeningHours()),
                // Help and Info
                Expanded(flex: 2, child: _buildHelpAndInfo()),
                // Newsletter
                Expanded(flex: 3, child: _buildNewsletter()),
              ],
            ),
          ] else ...[
            // Mobile: show only newsletter then social + payments + copyright (compact)
            _buildNewsletterMobile(),
            const SizedBox(height: 14),
            // social icons centered
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.facebook),
                    onPressed: () {},
                    splashRadius: 20,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.travel_explore), // placeholder for twitter
                    onPressed: () {},
                    splashRadius: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // payment badges centered and wrapped
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  _paymentBadge('Apple Pay'),
                  _paymentBadge('Discover'),
                  _payment_badge_small('G Pay'),
                  _payment_badge_small('Mastercard'),
                  _payment_badge_small('Visa'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // copyright centered (mobile)
            const Center(
              child: Text(
                '© 2025, upsu-store  Powered by Shopify',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
          ],

          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // mobile-specific newsletter layout (stacked, full-width subscribe)
  Widget _buildNewsletterMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('Latest Offers'),
        SizedBox(
          height: 44,
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              hintText: 'Email address',
              border: OutlineInputBorder(borderRadius: BorderRadius.zero),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton(
            onPressed: _subscribe,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            child: const Text('SUBSCRIBE', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  // helper: slightly more compact badge variant used on mobile
  Widget _payment_badge_small(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Text(label, style: const TextStyle(fontSize: 11)),
    );
  }

  Widget _buildOpeningHours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Opening Hours'),
        const Text('❄️ Winter Break Closure Dates ❄️', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        const Text('Closing 4pm 19/12/2025', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        const Text('Reopening 10am 05/01/2026', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        const Text('Last post date: 12pm on 18/12/2025', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        const Text('-----------------------'),
        const SizedBox(height: 8),
        const Text('(Term Time)', style: TextStyle(fontStyle: FontStyle.italic)),
        const SizedBox(height: 6),
        const Text('Monday - Friday 10am - 4pm', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        const Text('(Outside of Term Time / Consolidation Weeks)', style: TextStyle(fontStyle: FontStyle.italic)),
        const SizedBox(height: 6),
        const Text('Monday - Friday 10am - 3pm', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        const Text('Purchase online 24/7', style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildHelpAndInfo() {
    Widget link(String label) => TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 24)),
          child: Align(alignment: Alignment.centerLeft, child: Text(label, style: const TextStyle(color: Colors.black))),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Help and Information'),
        link('Search'),
        link('Terms & Conditions of Sale'),
        link('Privacy Policy'),
      ],
    );
  }

  Widget _buildNewsletter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Latest Offers'),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    hintText: 'Email address',
                    border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: _subscribe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: const Text('SUBSCRIBE', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
