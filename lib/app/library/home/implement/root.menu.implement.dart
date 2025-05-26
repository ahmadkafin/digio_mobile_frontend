import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';

abstract class RootMenuImplement {
  Future<List<MenuResponse>> get(String token);
}

class RootMenuRepoImplement implements RootMenuImplement {
  Dio? dio;
  List<MenuResponse> data = [];

  RootMenuRepoImplement() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.50.254:8080/",
        responseType: ResponseType.json,
      ),
    );
  }

  @override
  Future<List<MenuResponse>> get(String token) async {
    try {
      Response response = await dio!.post(
        'rootmenu/get',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data == []) {
          return [];
        } else {
          data = response.data['data']
              .map<MenuResponse>((json) => MenuResponse.fromJson(json))
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

final rootMenuRepoProvider = Provider<RootMenuRepoImplement>(
  (ref) {
    return RootMenuRepoImplement();
  },
);
