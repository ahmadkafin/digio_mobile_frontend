import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/child/implements/child.implements.dart';
import 'package:myapp/app/library/child/repositories/child.repositories.dart';
import 'package:myapp/app/library/child/response/child.response.dart';
import 'package:myapp/app/library/splashscreen/repositories/splashscreen.repositories.dart';

class ChildProviders extends StateNotifier<AsyncValue<ChildResponse?>> {
  final Ref ref;

  ChildProviders({required this.ref}) : super(const AsyncData(null));

  Future<Either<bool, ChildResponse>> get() async {
    state = const AsyncLoading();
    try {
      final storage = ref.read(secureStorageProvider);
      final tokenStr = await storage.read(key: 'authToken');
      final dTokenStr = await storage.read(key: 'authDigioToken');
      if (tokenStr == null ||
          tokenStr.isEmpty ||
          dTokenStr == null ||
          dTokenStr.isEmpty) {
        state = const AsyncValue.data(null);
        return Left(false);
      }
      final res = await ref.read(childRepoProvider).get(tokenStr, dTokenStr);
      final strgs = ref.read(childStorageServiceProvider);

      if (res == null) {
        state = const AsyncValue.data(null);
        return Left(false);
      }
      await strgs.setCookieData(res);
      state = AsyncData(res);
      return Right(res);
    } catch (e, st) {
      state = AsyncError(e, st);
      return const Left(false);
    }
  }
}

final childProvider =
    StateNotifierProvider<ChildProviders, AsyncValue<ChildResponse?>>(
  (ref) => ChildProviders(ref: ref),
);
