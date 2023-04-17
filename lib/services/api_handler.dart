import 'dart:convert';
import 'dart:math';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:store_app/consts/api_consts.dart';
import 'package:store_app/model/categories_model.dart';
import 'package:store_app/model/products_model.dart';
import 'package:store_app/model/users_model.dart';

class APIHandler {
  static Future<List<dynamic>> getAllDatas({
    required String target,
    String? limit,
  }) async {
    try {
      var uri = Uri.https(
          BASE_URL,
          "api/v1/$target",
          target == 'products'
              ? {
                  "offset": "0",
                  "limit": limit,
                }
              : {});
      var response = await http.get(uri); //trả về json

      //jsonDecode để parse chuối JSON thành một đối tượng Dart tương ứng
      var listDatas = jsonDecode(response.body);

      List tempList = [];
      if (response.statusCode != 200) {
        throw listDatas['message'];
      }

      for (var data in listDatas) {
        tempList.add(data);
      }

      return tempList;
    } catch (e) {
      log("An error occurred $e" as num);
      throw e.toString();
    }
  }

  static Future<List<ProductsModel>> getAllProducts({
    required String limit,
  }) async {
    List temp = await getAllDatas(target: "products", limit: limit);
    return ProductsModel.productsFromSnapshot(temp);
  }

  static Future<ProductsModel> getProductDetail({
    required String id,
  }) async {
    try {
      var uri = Uri.https(BASE_URL, "api/v1/products/$id");
      var response = await http.get(uri); //trả về json

      //jsonDecode để parse chuối JSON thành một đối tượng Dart tương ứng
      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw data['message'];
      }

      return ProductsModel.fromJson(data);
    } catch (e) {
      log("An error occurred while getting product infor $e" as num);
      throw e.toString();
    }
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
