import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/miracle/implements/miracles.implements.dart';
import 'package:myapp/app/library/miracle/response/miracles.response.dart';
import 'package:myapp/app/library/splashscreen/repositories/splashscreen.repositories.dart';

class MiracleProviders
    extends StateNotifier<AsyncValue<List<MiraclesResponse>?>> {
  final Ref ref;

  MiracleProviders({required this.ref}) : super(const AsyncData(null));

  Future<Either<bool, List<MiraclesResponse>>> get(
      String parentMenuid, String name) async {
    state = const AsyncLoading();
    try {
      final storage = ref.read(secureStorageProvider);
      final tokenStr = await storage.read(key: 'authToken');
      if (tokenStr == null || tokenStr.isEmpty) {
        state = const AsyncValue.data(null);
        return Left(false);
      }

      final res = await ref.read(miraclesRepoProvider).get(
            tokenStr,
            parentMenuid,
            name,
          );
      if (res == null) {
        state = const AsyncValue.data(null);
        return Left(false);
      }
      state = AsyncData(res);
      return Right(res);
    } catch (err, st) {
      state = AsyncError(err, st);
      return Left(false);
    }
  }
}

final miracleProvider = StateNotifierProvider<MiracleProviders,
    AsyncValue<List<MiraclesResponse>?>>(
  (ref) => MiracleProviders(ref: ref),
);
