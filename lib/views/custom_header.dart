import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final bool isMobile;
  final String activeNav;
  final Map<String, bool> hovering;
  final void Function(String, bool) onHover;
  final void Function(String) onSetActive;
  final VoidCallback placeholderCallback;
  final VoidCallback toggleMobileMenu;
  final bool mobileMenuOpen;
  final void Function(BuildContext) navigateToHome;
  final void Function(BuildContext) navigateToProduct;
  final void Function(BuildContext) navigateToAbout;
  final void Function(BuildContext) navigateToClothing;
  final void Function(BuildContext) navigateToEssentials;
  final void Function(BuildContext) navigateToMerchandise;
  final void Function(BuildContext) navigateToSale;
  final void Function(BuildContext) navigateToSearch;
  final void Function(BuildContext) navigateToWinter;
  final void Function(BuildContext) navigateToAll;

  const CustomHeader({
    super.key,
    required this.isMobile,
    required this.activeNav,
    required this.hovering,
    required this.onHover,
    required this.onSetActive,
    required this.placeholderCallback,
    required this.toggleMobileMenu,
    required this.mobileMenuOpen,
    required this.navigateToHome,
    required this.navigateToProduct,
    required this.navigateToAbout,
    required this.navigateToClothing,
    required this.navigateToEssentials,
    required this.navigateToMerchandise,
    required this.navigateToSale,
    required this.navigateToAll,
    required this.navigateToSearch,
    required this.navigateToWinter,
  });

  @override
  Widget build(BuildContext context) {
    // shorter desktop header
    final headerHeight = isMobile ? 120.0 : 130.0;

    return Container(
      height: headerHeight,
      color: Colors.white,
      child: Column(
        children: [
          // Top banner
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: isMobile ? 14 : 10, horizontal: isMobile ? 12 : 25),
            color: const Color(0xFF4d2963),
            child: Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                // smaller font on mobile
                fontSize: isMobile ? 13 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Main header
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 50),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final headerIsMobile = constraints.maxWidth < 700;
                  if (headerIsMobile) {
                    // Mobile header: logo + icons + hamburger
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
                        IconButton(
                          icon: const Icon(Icons.search, size: 20, color: Colors.black),
                          onPressed: () => navigateToSearch(context),
                        ),
                        IconButton(
                          icon: const Icon(Icons.person_outline, size: 20, color: Colors.black),
                          onPressed: placeholderCallback,
                        ),
                        IconButton(
                          icon: const Icon(Icons.shopping_bag_outlined, size: 20, color: Colors.black),
                          onPressed: () => Navigator.pushNamed(context, '/cart'),
                        ),
                        // show menu or X depending on open state, slide-down from beneath header
                        IconButton(
                          icon: Icon(mobileMenuOpen ? Icons.close : Icons.menu, color: Colors.black),
                          // always toggle the in-tree slide-down menu (do not open the Scaffold drawer)
                          onPressed: toggleMobileMenu,
                        ),
                      ],
                    );
                  }

                  // Desktop header: logo + nav + icons (no hamburger)
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

                      // center nav items
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, c) {
                            final useRow = c.maxWidth > 520;
                            final navItems = <Widget>[
                              // Home (hover + active)
                              MouseRegion(
                                onEnter: (_) => onHover('Home', true),
                                onExit: (_) => onHover('Home', false),
                                child: SizedBox(
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
                                        decoration: (activeNav == 'Home' || (hovering['Home'] ?? false)) ? TextDecoration.underline : TextDecoration.none,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Shop (popup)
                              MouseRegion(
                                onEnter: (_) => onHover('Shop', true),
                                onExit: (_) => onHover('Shop', false),
                                child: SizedBox(
                                  height: 36,
                                  child: PopupMenuButton<String>(
                                    onSelected: (v) {
                                      onSetActive('Shop');
                                      if (v == 'clothing') {
                                        navigateToClothing(context);
                                      } else if (v == 'merchandise') {
                                        navigateToMerchandise(context);
                                      } else if (v == 'essentials') {
                                        navigateToEssentials(context);
                                      } else if (v == 'winter') {
                                        navigateToWinter(context);
                                      } else if (v == 'all') {
                                        navigateToAll(context);
                                      } else {
                                        placeholderCallback();
                                      }
                                    },
                                    itemBuilder: (_) => const [
                                      PopupMenuItem(value: 'clothing', child: Text('Clothing')),
                                      PopupMenuItem(value: 'merchandise', child: Text('Merchandise')),
                                      PopupMenuItem(value: 'essentials', child:Text('Essentials')),
                                      PopupMenuItem(value: 'winter', child: Text('Winter')),
                                      PopupMenuItem(value: 'all', child: Text('All Products')),
                                    ],
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Shop',
                                            style: TextStyle(
                                              decoration: (activeNav == 'Shop' || (hovering['Shop'] ?? false)) ? TextDecoration.underline : TextDecoration.none,
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
                              ),

                              // The Print Shack (popup)
                              MouseRegion(
                                onEnter: (_) => onHover('The Print Shack', true),
                                onExit: (_) => onHover('The Print Shack', false),
                                child: SizedBox(
                                  height: 36,
                                  child: PopupMenuButton<String>(
                                    onSelected: (v) {
                                      onSetActive('The Print Shack');
                                      if (v == 'about') {
                                        Navigator.pushNamed(context, '/printshack-about');
                                      } else if (v == 'personalisation') {
                                        Navigator.pushNamed(context, '/printshack-personalisation');
                                      } else {
                                        placeholderCallback();
                                      }
                                    },
                                    itemBuilder: (_) => const [
                                      PopupMenuItem(value: 'about', child: Text('About')),
                                      PopupMenuItem(value: 'personalisation', child: Text('Personalisation')),
                                    ],
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'The Print Shack',
                                            style: TextStyle(
                                              decoration: (activeNav == 'The Print Shack' || (hovering['The Print Shack'] ?? false)) ? TextDecoration.underline : TextDecoration.none,
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
                              ),

                              // SALE!
                              MouseRegion(
                                onEnter: (_) => onHover('SALE!', true),
                                onExit: (_) => onHover('SALE!', false),
                                child: SizedBox(
                                  height: 36,
                                  child: TextButton(
                                    onPressed: () {
                                      onSetActive('SALE!');
                                      navigateToSale(context);
                                    },
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      minimumSize: const Size(0, 36),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      'SALE!',
                                      style: TextStyle(
                                        color: Colors.black,
                                        decoration: (activeNav == 'SALE!' || (hovering['SALE!'] ?? false)) ? TextDecoration.underline : TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // About
                              MouseRegion(
                                onEnter: (_) => onHover('About', true),
                                onExit: (_) => onHover('About', false),
                                child: SizedBox(
                                  height: 36,
                                  child: TextButton(
                                    onPressed: () => navigateToAbout(context),
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      minimumSize: const Size(0, 36),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      'About',
                                      style: TextStyle(
                                        decoration: (activeNav == 'About' || (hovering['About'] ?? false)) ? TextDecoration.underline : TextDecoration.none,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ];

                            if (useRow) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: navItems.map((w) => Padding(padding: const EdgeInsets.symmetric(horizontal: 6.0), child: w)).toList(),
                              );
                            }

                            // fallback (rare): wrap
                            return Center(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 12,
                                runSpacing: 6,
                                children: navItems,
                              ),
                            );
                          },
                        ),
                      ),

                      // right-side icons (desktop only)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.search, size: 24, color: Colors.black),
                            onPressed: () => navigateToSearch(context),
                          ),
                          IconButton(
                            icon: const Icon(Icons.person_outline, size: 24, color: Colors.black),
                            onPressed: placeholderCallback,
                          ),
                          IconButton(
                            icon: const Icon(Icons.shopping_bag_outlined, size: 24, color: Colors.black),
                            onPressed: () => Navigator.pushNamed(context, '/cart'),
                          ),
                          // no menu icon here on desktop
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
    );
  }
}
