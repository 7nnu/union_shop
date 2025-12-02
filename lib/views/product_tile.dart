import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'dart:math' as math;

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  const ProductTile({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (product.imageUrl.startsWith('assets/')) {
      imageWidget = Image.asset(
        product.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => Container(
          color: Colors.grey[300],
          child: const Center(child: Icon(Icons.image_not_supported, color: Colors.grey)),
        ),
      );
    } else {
      imageWidget = Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => Container(
          color: Colors.grey[300],
          child: const Center(child: Icon(Icons.image_not_supported, color: Colors.grey)),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap ?? () => Navigator.pushNamed(context, '/product', arguments: product),
      // Use LayoutBuilder so we can allocate a fixed portion of the tile height to the image.
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Prefer tile width for a square image. If width is unbounded, fall back
          // to a portion of maxHeight or a fixed size.
          double imageSize;
          if (constraints.maxWidth.isFinite && constraints.maxWidth > 0) {
            imageSize = constraints.maxWidth;
          } else if (constraints.maxHeight.isFinite && constraints.maxHeight > 0) {
            imageSize = constraints.maxHeight * 0.5;
          } else {
            imageSize = 200.0;
          }
          // clamp to a reasonable maximum
          imageSize = math.min(imageSize, 300.0);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: imageSize,
                width: imageSize,
                child: ClipRRect(
                  borderRadius: BorderRadius.zero,
                  clipBehavior: Clip.hardEdge,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: imageSize,
                      height: imageSize,
                      child: imageWidget,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                product.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (product.original != null)
                    Text(
                      product.original!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  if (product.original != null) const SizedBox(width: 8),
                  Text(
                    product.price,
                    style: TextStyle(fontSize: 14, color: Colors.blue.shade700, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
