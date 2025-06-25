import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/auth/request/auth.request.dart';
import 'package:myapp/app/library/auth/response/auth.response.dart';
import 'package:myapp/core/utils/endpoint.utils.dart';

abstract class AuthImplement {
  Future<AuthResponse> login({required AuthRequest request});
  // Future<AuthResponse> logout();
  // Future<AuthResponse> refreshToken(String token);
}

class AuthRepoImplement implements AuthImplement {
  Dio? dio;
  AuthRepoImplement() {
    dio = Dio(
      BaseOptions(
        baseUrl: url,
        responseType: ResponseType.json,
      ),
    );
  }

  @override
  Future<AuthResponse> login({required AuthRequest request}) async {
    try {
      Response response = await dio!.post(
        'auth/login',
        data: request.toJson(),
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (error) {
      // Handle Dio exceptions, such as network errors or server errors
      throw Exception('Login failed: ${error.message}');
    }
  }
}

final authRepoProvider = Provider<AuthRepoImplement>(
  (ref) => AuthRepoImplement(),
);
