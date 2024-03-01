import 'package:flutter/cupertino.dart';
import '../helpers/api_helper.dart';
import '../models/models.dart';

class ProductController extends ChangeNotifier {
  List<AllData> allProduct = <AllData>[];
  List<String> allCategory = <String>[];

  String selectCategory = "All";

  selectedCategory({required String category}) {
    selectCategory = category;
    notifyListeners();
  }

  init() async {
    allProduct = await ApiHelper.apiHelper.GetAllProduct();
    allCategory = allProduct.map((e) => e.category).toSet().toList();
    notifyListeners();
  }

  ProductController() {
    init();
    notifyListeners();
  }

  get AllProducts {
    return allProduct;
  }
}
