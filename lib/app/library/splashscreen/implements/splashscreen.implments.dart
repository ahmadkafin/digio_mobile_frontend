import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/utils/endpoint.utils.dart';

abstract class SplashScreenImplements {
  Future<bool> checkInitState(String token);
}

class SplashScreenRepoImplements implements SplashScreenImplements {
  Dio? dio;
  SplashScreenRepoImplements() {
    dio = Dio(
      BaseOptions(
        baseUrl: url,
        responseType: ResponseType.json,
      ),
    );
  }

  @override
  Future<bool> checkInitState(String token) async {
    try {
      Response response = await dio!.post(
        'home/isValidToken',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );
      print(response);
      if (response.statusCode != 200) {
        return false;
      }
      return true;
    } on DioException catch (e) {
      return false;
    }
  }
}

final splashScreenRepoProvider = Provider<SplashScreenRepoImplements>(
  (ref) => SplashScreenRepoImplements(),
);
