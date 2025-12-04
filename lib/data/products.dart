import 'package:union_shop/models/product.dart';

const List<Product> sampleEssentialsHome = [
    Product(
    title: 'Essential Hoodie',
    original: '£25.00',
    price: '£20.00',
    imageUrl: 'assets/images/hoodie.png',
  ),

  Product(
    title: 'Essential Jacket',
    original: '£50.00',
    price: '£40.00',
    imageUrl: 'assets/images/jacket.png',
  ),
];

const List<Product> sampleMerchandiseHome = [
    Product(
    title: 'University Tote Bag',
    price: '£8.00',
    imageUrl: 'assets/images/tote_bag.png',
  ),
  Product(
    title: 'University Mug',
    price: '£7.00',
    imageUrl: 'assets/images/mug.png',
  ),
];

const List<Product> sampleWinterProducts = [
  Product(
    title: 'Winter Scarf',
    price: '£15.00',
    imageUrl: 'assets/images/scarf.png',
  ),
  Product(
    title: 'Winter Beanie',
    price: '£12.00',
    imageUrl: 'assets/images/black_beanie.png',
  ),
  Product(
    title: 'Winter Gloves',
    price: '£12.00',
    imageUrl: 'assets/images/gloves.png',
  ),
  Product(
    title: 'Winter Jacket',
    price: '£50.00',
    imageUrl: 'assets/images/jacket.png',
  ),
];

const List<Product> sampleMerchandiseProducts = [
  Product(
    title: 'University Tote Bag',
    price: '£8.00',
    imageUrl: 'assets/images/tote_bag.png',
  ),
  Product(
    title: 'University Mug',
    price: '£10.00',
    imageUrl: 'assets/images/mug.png',
  ),
  Product(
    title: 'University Notebook',
    price: '£6.00',
    imageUrl: 'assets/images/notebook.png',
  ),
  Product(
    title: 'University Pen',
    price: '£3.00',
    imageUrl: 'assets/images/pen.png',
  ),
  Product(
    title: 'University Lanyard',
    price: '£4.00',
    imageUrl: 'assets/images/lanyard.png',
  ),
];

const List<Product> sampleEssentialProducts = [
  Product(
    title: 'Essential Hoodie',
    original: '£25.00',
    price: '£20.00',
    imageUrl: 'assets/images/hoodie.png',
  ),

  Product(
    title: 'Essential T-Shirt',
    original: '£15.00',
    price: '£12.00',
    imageUrl: 'assets/images/tshirt.png',
  ),

  Product(
    title: 'Essential Jacket',
    original: '£50.00',
    price: '£40.00',
    imageUrl: 'assets/images/jacket.png',
  ),

];

const List<Product> sampleClothingProducts = [
  Product(
    title: 'University Hoodie',
    price: '£25.00',
    imageUrl: 'assets/images/hoodie.png',
  ),
  Product(
    title: 'University T-Shirt',
    price: '£15.00',
    imageUrl: 'assets/images/tshirt.png',
  ),
  Product(
    title: 'University Jacket',
    price: '£50.00',
    imageUrl: 'assets/images/jacket.png',
  ),
  
];

const List<Product> sampleSaleProducts = [
 Product(
    title: 'Beanie — Pink (Pom)',
    original: '£12.00',
    price: '£9.00',
    imageUrl: 'assets/images/pink_beanie.png',
  ),
  Product(
    title: 'Beanie — Navy',
    original: '£12.00',
    price: '£9.00',
    imageUrl: 'assets/images/navy_beanie.png',
  ),
  ...sampleEssentialProducts,
];

const List<Product> sampleAllProducts = [
  ...sampleWinterProducts,
  ...sampleMerchandiseProducts,
  ...sampleEssentialProducts,
  ...sampleClothingProducts,
];
