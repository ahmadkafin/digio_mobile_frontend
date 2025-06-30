import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myapp/app/library/auth/response/auth.response.dart';

const isAuthKey = 'isAuthKey';
const authUserKey = 'authUserKey';
const authTokenKey = 'authToken';
const authExpiryKey = 'authExpire';
const authDigioTokenKey = 'authDigioToken';
const cookieData = 'cookieData';

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

class AuthStoragerRepositories {
  final FlutterSecureStorage storage;
  AuthStoragerRepositories(this.storage);

  Future<void> setAuthData(AuthResponse data) async {
    await storage.write(key: isAuthKey, value: 'true');
    await storage.write(key: authUserKey, value: json.encode(data));
    await storage.write(key: authTokenKey, value: data.token ?? '');
    await storage.write(key: authDigioTokenKey, value: data.digioToken ?? '');
    await storage.write(
      key: authExpiryKey,
      value: DateTime.now()
          .add(Duration(seconds: data.expires ?? 0))
          .toIso8601String(),
    );
  }

  Future<void> clear() async {
    await storage.delete(key: isAuthKey);
    await storage.delete(key: authTokenKey);
    await storage.delete(key: authUserKey);
    await storage.delete(key: authExpiryKey);
    await storage.delete(key: authDigioTokenKey);
    await storage.delete(key: cookieData);
  }

  Future<bool> isAuthenticated() async {
    final value = await storage.read(key: isAuthKey);
    return value == 'true';
  }

  Future<AuthResponse?> getUserAuth() async {
    final jsonStr = await storage.read(key: authUserKey);
    if (jsonStr == null) return null;
    return AuthResponse.fromJson(json.decode(jsonStr));
  }

  Future<String?> getToken() async {
    return await storage.read(key: authTokenKey);
  }

  Future<String?> getDigioToken() async {
    return await storage.read(key: authDigioTokenKey);
  }

  Future<bool> isExpired() async {
    final expireStr = await storage.read(key: authExpiryKey);
    final expireInSeconds = int.tryParse(expireStr ?? '0') ?? 0;
    final expireTime = DateTime.now().add(Duration(seconds: expireInSeconds));
    return expireTime.isBefore(DateTime.now());
  }
}

final authStorageServiceProvider = Provider<AuthStoragerRepositories>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return AuthStoragerRepositories(storage);
});

final setAuthDataProvider =
    FutureProvider.family<void, AuthResponse>((ref, data) async {
  await ref.watch(authStorageServiceProvider).setAuthData(data);
});

final isAuthProvider = FutureProvider<bool>((ref) async {
  final result = await ref.watch(authStorageServiceProvider).isAuthenticated();
  print("isAuthProvider evaluated: $result");
  return result;
});

final authUserProvider = FutureProvider<AuthResponse?>((ref) async {
  return await ref.watch(authStorageServiceProvider).getUserAuth();
});

final authTokenProvider = FutureProvider<String?>((ref) async {
  return await ref.watch(authStorageServiceProvider).getToken();
});

final authDigioTokenProvider = FutureProvider<String?>((ref) async {
  return await ref.watch(authStorageServiceProvider).getDigioToken();
});

final authExpireProvider = FutureProvider<bool>((ref) async {
  return await ref.watch(authStorageServiceProvider).isExpired();
});

final resetAuthProvider = FutureProvider<void>((ref) async {
  return await ref.watch(authStorageServiceProvider).clear();
});
