class Product {
  final String title;
  final String price;
  final String imageUrl;
  final String? original;

  const Product({
    required this.title,
    required this.price,
    required this.imageUrl,
    this.original,
  });
}
