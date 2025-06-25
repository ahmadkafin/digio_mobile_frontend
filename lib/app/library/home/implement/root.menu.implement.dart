import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';
import 'package:myapp/core/utils/endpoint.utils.dart';

abstract class RootMenuImplement {
  Future<List<MenuResponse>> get(
      String token, String username, String directory);
}

class RootMenuRepoImplement implements RootMenuImplement {
  Dio? dio;
  List<MenuResponse> data = [];

  RootMenuRepoImplement() {
    dio = Dio(
      BaseOptions(
        baseUrl: url,
        responseType: ResponseType.json,
      ),
    );
  }

  @override
  Future<List<MenuResponse>> get(
    String token,
    String username,
    String directory,
  ) async {
    try {
      Response response = await dio!.post(
        'rootmenu/get',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
            'username': username,
            'directory': directory,
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
