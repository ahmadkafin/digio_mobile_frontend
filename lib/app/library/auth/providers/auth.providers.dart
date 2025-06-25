import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/auth/implement/auth.implement.dart';
import 'package:myapp/app/library/auth/repositories/authstorage.repositories.dart';
import 'package:myapp/app/library/auth/request/auth.request.dart';
import 'package:myapp/app/library/auth/response/auth.response.dart';
import 'package:myapp/app/library/splashscreen/providers/splashscreen.providers.dart';

class AuthProviders extends StateNotifier<AsyncValue<AuthResponse?>> {
  final Ref ref;

  AuthProviders({required this.ref}) : super(const AsyncData(null));

  Future<Either<bool, bool>> login({required AuthRequest request}) async {
    state = const AsyncLoading();

    try {
      final res = await ref.read(authRepoProvider).login(request: request);
      final storage = ref.read(authStorageServiceProvider);
      await storage.setAuthData(res);
      ref.invalidate(isAuthProvider);
      state = AsyncData(res);
      return const Right(true);
    } catch (e, st) {
      state = AsyncError(e, st);
      print(e.toString());
      return const Left(false);
    }
  }

  Future<void> logout() async {
    final storage = ref.read(authStorageServiceProvider);
    await storage.clear();
    ref.invalidate(isAuthProvider);
    ref.invalidate(splashScreenProviders);
    await Future.delayed(const Duration(milliseconds: 100)); // optional delay
    ref.read(splashScreenProviders.notifier).get();
    state = AsyncData(null);
  }
}

final authProvider =
    StateNotifierProvider<AuthProviders, AsyncValue<AuthResponse?>>(
  (ref) => AuthProviders(
    ref: ref,
  ),
);
