import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/auth/response/auth.response.dart';
import 'package:myapp/core/utils/endpoint.utils.dart';

abstract class RefreshTokenImplement {
  Future<AuthResponse> refreshToken(
      {required String token, required String username});
}

class RefreshTokenRepoImplement implements RefreshTokenImplement {
  Dio? dio;
  RefreshTokenRepoImplement() {
    dio = Dio(
      BaseOptions(
        baseUrl: url,
        responseType: ResponseType.json,
      ),
    );
  }

  @override
  Future<AuthResponse> refreshToken(
      {required String token, required String username}) async {
    try {
      Response response = await dio!.post(
        'auth/refreshToken',
        data: {
          "token": token,
          "username": username,
        },
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (error) {
      throw Exception('Login failed : ${error.message}');
    }
  }
}

final refreshTokenRepoProvider = Provider<RefreshTokenRepoImplement>(
  (ref) => RefreshTokenRepoImplement(),
);
