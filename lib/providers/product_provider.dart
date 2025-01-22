import 'dart:developer';

import 'package:ecommerce_app_2/data/models/product_model.dart';
import 'package:ecommerce_app_2/data/repositories/product_repo.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepo productRepo;

  ProductProvider({required this.productRepo});

  bool isLoading = false;
  bool isLoadingMore = false;
  List<ProductModel> products = [];
  List<Category> categories = [];
  int pageNumber = 1;
  int limit = 10;
  int selectedCategory = 1;

  Future<void> getProducts() async {
    isLoading = true;
    notifyListeners();
    final allProductsData = await productRepo.fetchProduts(
      limit: limit,
      page: pageNumber,
    );

    products.addAll(allProductsData
        .map(
          (e) => ProductModel.fromJson(e),
        )
        .toList());
    isLoading = false;
    notifyListeners();
  }

  // load more products
  Future<void> loadMoreProducts({required int pageNum}) async {
    isLoadingMore = true;
    notifyListeners();
    log(pageNum.toString());
    final productsData = await productRepo.fetchProduts(
      limit: limit,
      page: pageNum,
    );
    products.addAll(
      productsData
          .map(
            (e) => ProductModel.fromJson(e),
          )
          .toList(),
    );
    log(products.toString());
    isLoadingMore = false;
    notifyListeners();
  }

  // add new product
  Future<bool> addNewProduct({
    required String title,
    required String description,
    required double price,
  }) async {
    isLoading = true;
    notifyListeners();
    final result = await productRepo.createProduct(
      title: title,
      description: description,
      price: price,
      categoryId: selectedCategory,
    );
    log(result.toString());
    isLoading = false;
    notifyListeners();
    return result;
  }

  // get categories
  Future<void> getCategories() async {
    notifyListeners();
    final response = await productRepo.getCategories();
    categories.addAll(
      response
          .map(
            (e) => Category.fromJson(e),
          )
          .toList(),
    );
    log(categories.toString());

    notifyListeners();
  }
}
