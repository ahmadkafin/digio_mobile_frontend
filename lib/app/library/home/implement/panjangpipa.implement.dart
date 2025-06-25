import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/response/panjangpipa.response.dart';
import 'package:myapp/core/utils/endpoint.utils.dart';

abstract class PanjangPipaImplement {
  Future<List<PanjangPipaResponse>> get(String token);
}

class PanjangPipaRepoImplement implements PanjangPipaImplement {
  Dio? dio;
  List<PanjangPipaResponse> data = [];
  PanjangPipaRepoImplement() {
    dio = Dio(
      BaseOptions(
        baseUrl: url,
        responseType: ResponseType.json,
      ),
    );
  }

  @override
  Future<List<PanjangPipaResponse>> get(String token) async {
    try {
      Response response = await dio!.post(
        'home/panjangpipa',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data['data'] == []) {
          return [];
        } else {
          data = response.data['data']
              .map<PanjangPipaResponse>(
                  (json) => PanjangPipaResponse.fromJson(json))
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

final panjangPipaRepoProvider = Provider<PanjangPipaRepoImplement>(
  (ref) => PanjangPipaRepoImplement(),
);
