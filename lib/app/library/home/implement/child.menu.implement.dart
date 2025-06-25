import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';
import 'package:myapp/core/utils/endpoint.utils.dart';

abstract class ChildMenuImplement {
  Future<List<MenuResponse>> get(
      String token, String username, String direcotry, String parrentid);
}

class ChildMenuRepoImplement implements ChildMenuImplement {
  Dio? dio;
  List<MenuResponse> data = [];

  ChildMenuRepoImplement() {
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
    String parrentid,
  ) async {
    try {
      Response response = await dio!.post(
        'menu/get',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
            'username': username,
            'directory': directory,
            'menu_parentid': parrentid,
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data['data'] == []) {
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
      debugPrint(error.message.toString());
      return [];
    }
  }
}

final childMenuRepoProvider = Provider<ChildMenuRepoImplement>(
  (ref) {
    return ChildMenuRepoImplement();
  },
);
