import 'package:ecommerce_app_2/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard2 extends StatelessWidget {
  final String title;
  final String image;
  final int price;
  final double rating;
  final int reviewCount;
  final int id;

  const ProductCard2({
    required this.title,
    required this.image,
    required this.price,
    required this.rating,
    required this.reviewCount,
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // Access the ProductProvider using context.read()
    final productProvider = Provider.of<ProductProvider>(context, listen: true);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              child: Center(
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Product Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Price
            Text(
              "USD $price",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            // Rating and Reviews
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  rating.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "$reviewCount Reviews",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                // View Button
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Expanded(
                          child: AlertDialog(
                            title: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: Image.network(image)),
                                SizedBox(height: 10),
                                Text("Price: USD $price"),
                                SizedBox(height: 10),
                                Text("Rating: $rating"),
                                SizedBox(height: 10),
                                Text("$reviewCount Reviews"),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Close"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text("View"),
                ),
                // Buy Button
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Product added to cart!"),
                      ),
                    );
                  },
                  child: Text("Buy"),
                ),
                // Delete Button
                TextButton(
                  onPressed: () {
                    productProvider.deleteItem(id);
                  },
                  child: Text("Delete item"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
