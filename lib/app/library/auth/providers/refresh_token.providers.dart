import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/auth/implement/refresh_token.implement.dart';
import 'package:myapp/app/library/auth/repositories/authstorage.repositories.dart';
import 'package:myapp/app/library/auth/response/auth.response.dart';

class RefreshTokenProviders extends StateNotifier<AsyncValue<AuthResponse?>> {
  final Ref ref;

  RefreshTokenProviders({required this.ref}) : super(const AsyncData(null));

  Future<Either<bool, bool>> refreshToken() async {
    try {
      state = const AsyncLoading();
      final storages = ref.read(secureStorageProvider);
      final authStr = await storages.read(key: 'authUserKey');

      if (authStr == null) {
        state = AsyncError(
          'No auth data found',
          StackTrace.current,
        );
        print('Err: $authStr');
        return const Left(false);
      }

      final userJson = jsonDecode(authStr) as Map<String, dynamic>;
      final username = userJson['username'] as String?;
      final token = userJson['token'] as String?;

      final res = await ref.read(refreshTokenRepoProvider).refreshToken(
            token: token!,
            username: username!,
          );

      final storage = ref.read(authStorageServiceProvider);
      await storage.setAuthData(res);
      ref.invalidate(isAuthProvider);
      state = AsyncData(res);
      return const Right(true);
    } catch (e, st) {
      state = AsyncError(e, st);
      print('Error $e');
      return const Left(false);
    }
  }
}

final refreshTokenProvider =
    StateNotifierProvider<RefreshTokenProviders, AsyncValue<AuthResponse?>>(
  (ref) => RefreshTokenProviders(ref: ref),
);
