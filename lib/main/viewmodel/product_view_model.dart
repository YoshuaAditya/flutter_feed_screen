import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feed_screen/main/models/feed.dart';
import 'package:http/http.dart' as http;

class ProductViewModel extends ChangeNotifier {
  final List<Product> _products = [];
  int skipItems = 0;
  int limitItems = 10;
  bool isLoading = true;

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void addProducts(List<Product> products) {
    _products.addAll(products);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }

  void updateProduct(Product oldProduct, Product newProduct) {
    final index = _products.indexOf(oldProduct);
    _products[index] = newProduct;
    notifyListeners();
  }

  Feed? feedResponse;

  getData() async {
    try {
      isLoading = true;
      notifyListeners();
      String url =
          "https://dummyjson.com/products?limit=$limitItems&skip=$skipItems";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        feedResponse = Feed.fromJson(json.decode(res.body));
        _products.addAll(feedResponse?.products as Iterable<Product>);
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
