import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/response/detailasset.response.dart';
import 'package:myapp/core/utils/endpoint.utils.dart';

abstract class DetailAssetImplement {
  Future<List<DetailAssetResponse>> get(String token, String name);
}

class DetailAssetRepoImplement implements DetailAssetImplement {
  Dio? dio;
  List<DetailAssetResponse> data = [];
  DetailAssetRepoImplement() {
    dio = Dio(
      BaseOptions(
        baseUrl: url,
        responseType: ResponseType.json,
      ),
    );
  }

  @override
  Future<List<DetailAssetResponse>> get(String token, String nama) async {
    try {
      Response response = await dio!.post(
        'home/detailasset',
        data: {
          "name": nama,
        },
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
              .map<DetailAssetResponse>(
                  (json) => DetailAssetResponse.fromJson(json))
              .toList();
          return data;
        }
      }
      return [];
    } on DioException catch (e) {
      debugPrint(e.message);
      return [];
    }
  }
}

final detailAssetRepoProvider = Provider<DetailAssetRepoImplement>(
  (ref) => DetailAssetRepoImplement(),
);
