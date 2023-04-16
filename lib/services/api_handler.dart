import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:store_app/consts/api_consts.dart';
import 'package:store_app/model/categories_model.dart';
import 'package:store_app/model/products_model.dart';
import 'package:store_app/model/users_model.dart';

class APIHandler {
  static Future<List<dynamic>> getAllDatas({
    required String target,
  }) async {
    var uri = Uri.https(BASE_URL, "api/v1/$target");
    var response = await http.get(uri); //trả về json

    //jsonDecode để parse chuối JSON thành một đối tượng Dart tương ứng
    var listDatas = jsonDecode(response.body);

    List tempList = [];

    for (var data in listDatas) {
      tempList.add(data);
    }

    return tempList;
  }

  static Future<List<ProductsModel>> getAllProducts() async {
    List temp = await getAllDatas(target: "products");
    return ProductsModel.productsFromSnapshot(temp);
  }

  static Future<ProductsModel> getProductDetail({
    required String id,
  }) async {
    var uri = Uri.https(BASE_URL, "api/v1/products/$id");
    var response = await http.get(uri); //trả về json

    //jsonDecode để parse chuối JSON thành một đối tượng Dart tương ứng
    var data = jsonDecode(response.body);

    return ProductsModel.fromJson(data);
  }

  static Future<List<CategoriesModel>> getAllCategories() async {
    List temp = await getAllDatas(target: "categories");
    return CategoriesModel.categoriesFromSnapshot(temp);
  }

  static Future<List<UsersModel>> getAllUsers() async {
    List temp = await getAllDatas(target: "users");
    return UsersModel.usersFromSnapshot(temp);
  }
}
