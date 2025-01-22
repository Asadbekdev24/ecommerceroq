import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app_2/common/utils/network_constants.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  Future<List<dynamic>> fetchProduts({
    required int limit,
    required int page,
  }) async {
    final url = Uri.parse(
      "${NetworkConstants.productsUrl}?limit=$limit&offset=$page",
    );

    try {
      final response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        log(response.body);
        final payload = jsonDecode(response.body);
        // final products = payload.map((e) => ProductModel.fromJson(e)).toList();
        return payload;
      }

      throw Exception("Error happened while fetching products");
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  // create new product
  Future<bool> createProduct({
    required String title,
    required String description,
    required double price,
    required int categoryId,
  }) async {
    final url = Uri.parse(NetworkConstants.productsUrl);
    final data = {
      "title": title,
      "description": description,
      "price": price,
      "categoryId": categoryId,
      "images": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmCy16nhIbV3pI1qLYHMJKwbH2458oiC9EmA&s"
      ]
    };
    try {
      final response = await http.post(
        headers: {"Content-Type": "application/json"},
        url,
        body: jsonEncode(data),
      );
      log(response.body);

      if (response.statusCode == 201) {
        log(response.body);
        return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  Future<List<dynamic>> getCategories() async {
    final url = Uri.parse(NetworkConstants.categoriesUrl);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final payload = jsonDecode(response.body);
        return payload;
      }
      throw Exception("Error in loading categories");
    } catch (e) {
      throw Exception(e);
    }
  }
}
