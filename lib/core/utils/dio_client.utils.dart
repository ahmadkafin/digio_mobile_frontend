import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myapp/app/library/auth/repositories/authstorage.repositories.dart';
import 'package:myapp/core/utils/endpoint.utils.dart';
import 'package:myapp/core/utils/jwt.utils.dart';

final dio = Dio();

bool _isDialogShown = false;

void setupDioInterceptor({required Function() onTokenAlmostExpired}) {
  dio.options = BaseOptions(
    baseUrl: url,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  dio.interceptors.clear();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final storage = FlutterSecureStorage();
        final token = await AuthStoragerRepositories(storage).getToken();

        if (token != null) {
          options.headers['Authorization'] = token;

          try {
            final payload = parseJwt(token);
            final exp =
                DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
            final remaining = exp.difference(DateTime.now()).inSeconds;

            if (remaining <= 30 && !_isDialogShown) {
              _isDialogShown = true;
              onTokenAlmostExpired(); // 👉 trigger dari widget
            }
          } catch (e) {
            print("Failed to parse JWT: $e");
          }
        }

        return handler.next(options);
      },
      onError: (e, handler) => handler.next(e),
    ),
  );
}
