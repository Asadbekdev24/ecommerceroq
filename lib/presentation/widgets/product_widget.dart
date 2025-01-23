import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String image;
  final int price;
  final int id;
  final VoidCallback onEdit;

  const ProductCard({
    required this.title,
    required this.image,
    required this.price,
    super.key,
    required this.id,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    // Access the ProductProvider using context.read()
    // final productProvider =
    //     Provider.of<ProductProvider>(context, listen: false);

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
                  image.startsWith("[")
                      ? image.substring(2, image.length - 2).toString()
                      : image,
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
                              textAlign: TextAlign.center,
                              title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: Image.network(
                                    image.startsWith("[")
                                        ? image
                                            .substring(2, image.length - 2)
                                            .toString()
                                        : image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("Price: USD $price"),
                                SizedBox(height: 10),
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
                  onPressed: onEdit,
                  child: Text("Edit"),
                ),
                // Delete Button
                TextButton(
                  onPressed: () {
                    // productProvider.deleteProduct(id);
                  },
                  child: Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
