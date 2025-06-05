import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/response/products.response.dart';

abstract class ProductsImplement {
  Future<List<ProductsResponse>> get(String token);
}

class ProductsRepoImplement implements ProductsImplement {
  Dio? dio;
  List<ProductsResponse> data = [];

  ProductsRepoImplement() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.50.254:8080/",
        responseType: ResponseType.json,
      ),
    );
  }

  @override
  Future<List<ProductsResponse>> get(String token) async {
    try {
      Response response = await dio!.post(
        'products/get',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data['data'] == []) {
          return [];
        } else {
          data = response.data['data']
              .map<ProductsResponse>((json) => ProductsResponse.fromJson(json))
              .toList();
          return data;
        }
      }
      return [];
    } on DioException catch (error) {
      debugPrint(error.message);
      return [];
    }
  }
}

final productsRepoProvider = Provider<ProductsRepoImplement>(
  (ref) {
    return ProductsRepoImplement();
  },
);
