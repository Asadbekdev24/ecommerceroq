import 'dart:developer';

import 'package:ecommerce_app_2/data/models/product_model.dart';
import 'package:ecommerce_app_2/data/services/injection_container.dart';
import 'package:ecommerce_app_2/presentation/screens/create_product_screen.dart';
import 'package:ecommerce_app_2/presentation/widgets/product_widget.dart';
import 'package:ecommerce_app_2/presentation/widgets/search_delegate.dart';
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
          // return CustomScrollView(
          //   physics: BouncingScrollPhysics(),
          //   slivers: [
          //     SliverAppBar(
          //       collapsedHeight: 70,
          //       stretch: true,
          //       centerTitle: true,
          //       // pinned: true,
          //       // floating: true,
          //       // snap: true,

          //       expandedHeight: 300,
          //       flexibleSpace: FlexibleSpaceBar(
          //         stretchModes: [
          //           StretchMode.zoomBackground,
          //         ],
          //         expandedTitleScale: 1.9,
          //         title: Text("Products"),
          //         background: Image.network(
          //           fit: BoxFit.cover,
          //           "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
          //         ),
          //       ),
          //       scrolledUnderElevation: 0,
          //       backgroundColor: Colors.pinkAccent,
          //     ),
          //     // SliverPadding(
          //     //   padding: const EdgeInsets.all(16),
          //     //   sliver: SliverGrid.builder(
          //     //     itemCount: productProvider.products.length,
          //     //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     //       crossAxisCount: 1,
          //     //     ),
          //     //     itemBuilder: (context, index) {
          //     //       final ProductModel product =
          //     //           productProvider.products[index];
          //     //       return ProductCard(
          //     //         onEdit: () {
          //     //           Navigator.push(
          //     //             context,
          //     //             MaterialPageRoute(
          //     //               builder: (context) => CreateProductScreen(
          //     //                 productModel: product,
          //     //               ),
          //     //             ),
          //     //           );
          //     //         },
          //     //         title: product.title.toString(),
          //     //         image: product.images![0],
          //     //         price: product.price!,
          //     //         id: product.id!,
          //     //       );
          //     //     },
          //     //   ),
          //     // ),
          //     SliverList.builder(
          //       itemCount: productProvider.products.length,
          //       itemBuilder: (context, index) {
          //         final ProductModel product = productProvider.products[index];
          //         return SizedBox(
          //           height: 350,
          //           child: ProductCard(
          //             onEdit: () {
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (context) => CreateProductScreen(
          //                     productModel: product,
          //                   ),
          //                 ),
          //               );
          //             },
          //             title: product.title.toString(),
          //             image: product.images![0],
          //             price: product.price!,
          //             id: product.id!,
          //           ),
          //         );
          //       },
          //     ),
          //     SliverToBoxAdapter(
          //       child: Container(
          //         child: Text(
          //           "Container",
          //         ),
          //       ),
          //     )
          //   ],
          // );
          return NestedScrollView(
            // The headerSliverBuilder callback defines the sliver widgets in the header
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                // SliverAppBar is the header that remains visible while scrolling
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'Nested Scroll View Example',
                      style: TextStyle(
                          fontSize: 16), // Customize the title's style
                    ),
                    background: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSf9fG0XSXlw5HHtdVIhc1_gl4vzcKeCOAkoBD07BHiTAyvsVoKqvRbLkwuNSTheOd3Kk4&usqp=CAU',
                      fit: BoxFit
                          .cover, // Ensure the image covers the entire area
                    ),
                  ),
                ),
              ];
            },
            // The body contains the scrollable content
            body: ListView.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'), // Display a list of items
                );
              },
            ),
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
