import 'dart:developer';

import 'package:ecommerce_app_2/data/models/product_model.dart';
import 'package:ecommerce_app_2/data/services/injection_container.dart';
import 'package:ecommerce_app_2/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateProductScreen extends StatefulWidget {
  final ProductModel? productModel;
  const CreateProductScreen({super.key, this.productModel});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final TextEditingController title = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController description = TextEditingController();

  final prodProvider = getIt<ProductProvider>();

  @override
  void initState() {
    super.initState();
    if (widget.productModel != null) {
      title.text = widget.productModel!.title.toString();
      price.text = widget.productModel!.price.toString();
      description.text = widget.productModel!.description.toString();
      prodProvider.selectedCategory = widget.productModel!.category!.id!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(hintText: "Title"),
                  controller: title,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Price"),
                  controller: price,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Description"),
                  controller: description,
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 100,
                  child: value.categories.isEmpty
                      ? ElevatedButton(
                          onPressed: () async {
                            await value.getCategories();
                            log(value.selectedCategory.toString());
                          },
                          child: Text("Select category"),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: value.categories.length,
                          itemBuilder: (context, index) {
                            final Category category = value.categories[index];
                            return GestureDetector(
                              onTap: () {
                                value.selectedCategory = category.id!;
                                value.updateSelectedCat(category.id!);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(right: 10),
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    border: value.categories[index].id ==
                                            value.selectedCategory
                                        ? Border.all(
                                            color: Colors.black,
                                            width: 2,
                                          )
                                        : null),
                                child: Text(
                                  category.name.toString(),
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                // ListWheelScrollView(
                //   itemExtent: 2,
                //   children: List.generate(
                //     prodProvider.categories.length,
                //     (index) {
                //       return Text(prodProvider.categories[index].name.toString());
                //     },
                //   ),
                // ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () async {
                    if (widget.productModel != null) {
                      final res = await prodProvider.editProduct(
                        id: widget.productModel!.id!,
                        title: title.text.trim(),
                        description: description.text.trim(),
                        price: double.parse(price.text.trim()),
                      );
                      if (res != false) {
                        Navigator.pop(context);
                      }
                      return;
                    }

                    final res = await prodProvider.addNewProduct(
                      title: title.text.trim(),
                      description: description.text.trim(),
                      price: double.parse(
                        price.text.trim(),
                      ),
                    );
                    if (res == true) {
                      Navigator.pop(context);
                    }
                  },
                  child: prodProvider.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          widget.productModel != null
                              ? "Update product"
                              : "Add product",
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
