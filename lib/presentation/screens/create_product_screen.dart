import 'dart:developer';

import 'package:ecommerce_app_2/data/models/product_model.dart';
import 'package:ecommerce_app_2/data/services/injection_container.dart';
import 'package:ecommerce_app_2/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

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
    prodProvider.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: prodProvider.categories.length,
                itemBuilder: (context, index) {
                  final Category category = prodProvider.categories[index];
                  return GestureDetector(
                    onTap: () {
                      prodProvider.selectedCategory = category.id!;
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 10),
                      height: 50,
                      color: Colors.amber,
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
                      "Add product",
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
