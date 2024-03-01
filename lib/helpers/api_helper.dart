import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ApiHelper {
  ApiHelper._();

  static final ApiHelper apiHelper = ApiHelper._();

  String api = "https://dummyjson.com/products";

  GetAllProduct() async {
    http.Response response = await http.get(
      Uri.parse(api),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      List product = data['products'];

      List<AllData> allProductData =
          product.map((e) => AllData.fromMap(data: e)).toList();

      return allProductData;
    }
  }
}
