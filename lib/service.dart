import 'package:flutter/foundation.dart';
import 'package:blocproducts/model.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://dummyjson.com/products';

  Future<UserModel> fetchCovidList() async {
    try {
      Response response = await _dio.get(_url);
      return UserModel.fromJson(response.data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return UserModel.withError("Data not found / Connection issue");
    }
  }
}
