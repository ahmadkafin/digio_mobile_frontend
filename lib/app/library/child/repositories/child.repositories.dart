import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myapp/app/library/child/response/child.response.dart';

const cookieData = 'cookieData';

final childResultProvider = StateProvider<ChildResponse?>((ref) => null);

final secureStorageRepoProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

class ChildRepositories {
  final FlutterSecureStorage storage;
  ChildRepositories(this.storage);

  Future<void> setCookieData(ChildResponse data) async {
    await storage.write(key: cookieData, value: jsonEncode(data.toJson()));
  }

  Future<ChildResponse?> getCookieData() async {
    final result = await storage.read(key: cookieData);
    if (result == null) return null;
    return ChildResponse.fromJson(jsonDecode(result));
  }
}

final childStorageServiceProvider = Provider<ChildRepositories>((ref) {
  final storage = ref.watch(secureStorageRepoProvider);
  return ChildRepositories(storage);
});

final cookieDataProvider = FutureProvider<ChildResponse?>((ref) async {
  return await ref.watch(childStorageServiceProvider).getCookieData();
});
