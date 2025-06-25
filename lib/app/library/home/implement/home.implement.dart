import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/response/home.response.dart';
import 'package:myapp/core/utils/endpoint.utils.dart';

abstract class HomeImplement {
  Future<List<HomeResponse>> get(String token);
}

class HomeRepoImplement implements HomeImplement {
  Dio? dio;
  List<HomeResponse> data = [];
  HomeRepoImplement() {
    dio = Dio(
      BaseOptions(
        baseUrl: url,
        responseType: ResponseType.json,
      ),
    );
  }

  @override
  Future<List<HomeResponse>> get(String token) async {
    try {
      Response response = await dio!.post(
        'home/dashboard',
        options: Options(
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data['data'] == []) {
          return [];
        } else {
          data = response.data['data']
              .map<HomeResponse>((json) => HomeResponse.fromJson(json))
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

final homeRepoProvider = Provider<HomeRepoImplement>(
  (ref) => HomeRepoImplement(),
);
