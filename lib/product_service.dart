import 'dart:convert';
import 'dart:developer';
import 'news_model.dart';
import 'package:http/http.dart'as http;


class ProductService {

  static const apiCall = 'https://newsapi.org/v2/everything?q=apple&from=2024-05-29&to=2024-05-29&sortBy=popularity&apiKey=5c2ceabb5ac84f48b78c4aafaa329741';

  Future<List<Articles>> fetchProducts() async {
    print('------------->1');

    final response = await http.get(Uri.parse(apiCall));

    if (response.statusCode == 200) {
      print('------------->2');
      Map<String, dynamic> body = json.decode(response.body);

      // Assuming the list of articles is under a key named 'articles'
      List<dynamic> articlesJson = body['articles'];

      // Convert the list of dynamic items to a list of Articles
      List<Articles> products = articlesJson.map((dynamic item) => Articles.fromJson(item)).toList();

      return products;
    } else {
      print('------------->3');

      throw Exception('Failed to load products');
    }
  }
}
