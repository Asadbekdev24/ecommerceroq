import 'package:ecommerce_app_2/data/models/product_model.dart';
import 'package:ecommerce_app_2/data/services/injection_container.dart';
import 'package:ecommerce_app_2/presentation/screens/create_product_screen.dart';
import 'package:ecommerce_app_2/presentation/widgets/product_widget.dart';
import 'package:ecommerce_app_2/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(
      () {
        if (scrollController.offset >
            scrollController.position.maxScrollExtent - 50) {
          getIt<ProductProvider>().loadMoreProducts(
            pageNum: getIt<ProductProvider>().pageNumber + 10,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (productProvider.products.isEmpty) {
            return Center(
              child: Text("No products found"),
            );
          }
          return GridView.builder(
            controller: scrollController,
            itemCount: productProvider.isLoadingMore
                ? productProvider.products.length + 1
                : productProvider.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemBuilder: (context, index) {
              if (index >= productProvider.products.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final ProductModel product = productProvider.products[index];
              return ProductCard(
                title: product.title.toString(),
                image: product.images![0],
                price: product.price!,
                id: product.id!,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateProductScreen(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
