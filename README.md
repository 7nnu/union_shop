# Union Shop

A lightweight Flutter e-commerce demo that mimics a university shop. It provides collection pages, product pages, a simple in-memory cart, search and a "Print Shack" personalisation flow. The app is designed primarily for web (mobile viewport) but supports desktop layouts.

## Key features
- Home page with featured sections and product tiles
- Product details with options (size/color), quantity selector and Add to Cart
- Simple in-memory Cart and Cart page
- Collection pages: Clothing, Merchandise, Essentials, Winter, All, Sale
- Search and Print Shack personalisation flow (one/two-line text + price calc)
- Responsive layout and shared UI components (header/footer/product tile)
- Hardcoded sample data in lib/data/products.dart for offline demo

## Quick start

Prerequisites
- Flutter SDK (stable) — includes Dart
- Chrome (recommended for web)
- Optional: Android/iOS toolchains or Windows desktop toolchain for native builds
- Recommended editor: VS Code with Flutter extension

Clone and open the project (Windows example)
```bash
git clone https://github.com/YOUR-USERNAME/union_shop.git
cd "c:\Users\tmhoo\Desktop\union_shop"
```

Install dependencies
```bash
flutter pub get
```

Run (web / Chrome)
```bash
flutter run -d chrome
```

Run (Windows desktop)
```bash
flutter config --enable-windows-desktop
flutter run -d windows
```

Open in VS Code
- File → Open Folder → select project folder
- Select device (Chrome / Windows) and press F5 or click Run

## Usage

Primary flows
- Home: browse featured products and collections. Click a product tile to open the Product page.
- Product page: choose size/color/quantity and Add to Cart.
- Cart: open the Cart page from the header to view and modify items. Cart is in-memory only.
- Collections: access via the header (CustomHeader) to view category pages.
- Search: use the header search to query the local product list.
- Print Shack: personalisation form with pricing shown on the Print Shack page.

Notes
- The app uses sample assets in assets/images/; if assets are missing, product tiles show a placeholder.
- The UI switches to a drawer/mobile menu when width < 700px.

Screenshots
- Place screenshots or GIFs in assets/images/ and reference them here. Example placeholders already included:
  - assets/images/hoodie.png
  - assets/images/tote_bag.png
  - assets/images/mug.png

## Running tests

Run all tests:
```bash
flutter test
```

Run a single test file (example — Cart page test):
```bash
flutter test test\views\cart_page_test.dart
```

Example test included:
- test/views/cart_page_test.dart — verifies empty cart message and presence of header icons

Run tests in VS Code: use the Test Explorer or CodeLens "Run test" above test functions.

## Project structure (high level)

- lib/
  - main.dart — app entry & routes
  - data/products.dart — hardcoded sample product data
  - models/
    - product.dart
    - cart.dart — simple in-memory cart model
  - views/
    - home_screen.dart
    - product_page.dart
    - cart_page.dart
    - printshack_personalisation.dart
    - printshack_about.dart
    - clothing_collection.dart, merchandise_collection.dart, essentials_collection.dart, winter_collection.dart, all_collection.dart, sale_collection.dart
    - custom_header.dart, custom_footer.dart, product_tile.dart
- assets/images/ — sample product images
- test/ — widget/unit tests (e.g. test/views/cart_page_test.dart)

## Technologies & dependencies
- Flutter + Dart (stable)
- Material design widgets
- Tests use flutter_test

## Known limitations
- No persistent storage: cart is in-memory only
- No backend or real authentication
- Product data is hardcoded (lib/data/products.dart)
- Checkout/payment flows are placeholders

## Future improvements
- Persist cart (shared_preferences/local DB)
- Backend integration (Firebase or REST API) for products, orders and auth
- Real checkout & payment flow
- Improve accessibility and i18n

## Contributing
- Fork → branch → commit → PR
- Run `flutter format .` and `flutter test` before opening PR
- Add tests for new features

## Contact
- Github  : 7nnu
