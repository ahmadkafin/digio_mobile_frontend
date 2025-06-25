import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/child/response/child.response.dart';
import 'package:myapp/core/utils/endpoint.utils.dart';

abstract class ChildImplement {
  Future<ChildResponse?> get(
    String token,
    String digioToken,
  );
}

class ChildRepoImplement implements ChildImplement {
  final Dio dio;
  ChildResponse? data;

  ChildRepoImplement()
      : dio = Dio(
          BaseOptions(
            baseUrl: url,
            responseType: ResponseType.json,
          ),
        );

  @override
  Future<ChildResponse?> get(
    String token,
    String digioToken,
  ) async {
    try {
      Response response = await dio.post(
        'home/getCookieData',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "digioToken": digioToken,
        },
      );

      if (response.statusCode != 200) {
        return null;
      }
      return ChildResponse.fromJson(response.data);
    } on DioException catch (err) {
      debugPrint(err.message);
      return null;
    }
  }
}

final childRepoProvider =
    Provider<ChildRepoImplement>((ref) => ChildRepoImplement());
