// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app_2/presentation/widgets/product_widget.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app_2/data/models/product_model.dart';

class SearchListDelegate extends SearchDelegate {
  final List<ProductModel> products;

  SearchListDelegate({
    required this.products,
  });
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(
          Icons.clear,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.menu,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<ProductModel> results = products
        .where((product) =>
            product.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final ProductModel product = results[index];
        return SizedBox(
          height: 350,
          child: ProductCard(
            onEdit: () {},
            title: product.title.toString(),
            image: product.images![0],
            price: product.price!,
            id: product.id!,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<ProductModel> suggestions = products
        .where(
          (product) =>
              product.title!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final ProductModel product = suggestions[index];
        return GestureDetector(
          onTap: () {
            query = product.title.toString();
            showResults(context);
          },
          child: ListTile(
            trailing: Text(
              "\$${product.price}",
            ),
            title: Text(
              product.title.toString(),
            ),
          ),
        );
      },
    );
  }
}
