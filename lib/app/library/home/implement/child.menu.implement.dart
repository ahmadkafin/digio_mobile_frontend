import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';

abstract class ChildMenuImplement {
  Future<List<MenuResponse>> get(String token, String parrentid);
}

class ChildMenuRepoImplement implements ChildMenuImplement {
  Dio? dio;
  List<MenuResponse> data = [];

  ChildMenuRepoImplement() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.50.254:8080/",
        responseType: ResponseType.json,
      ),
    );
  }

  @override
  Future<List<MenuResponse>> get(String token, String parrentid) async {
    try {
      Response response = await dio!.post(
        'menu/get',
        data: {
          "parrentid": parrentid,
        },
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
