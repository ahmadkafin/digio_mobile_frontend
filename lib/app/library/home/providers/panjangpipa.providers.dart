import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/implement/panjangpipa.implement.dart';
import 'package:myapp/app/library/home/repositories/panjangpipa.repositories.dart';
import 'package:myapp/app/library/home/response/panjangpipa.response.dart';

class PanjangPipaProviders
    extends StateNotifier<AsyncValue<List<PanjangPipaResponse>>> {
  final Ref ref;
  PanjangPipaProviders({required this.ref}) : super(const AsyncLoading());

  Future<Either<List<PanjangPipaResponse>, List<PanjangPipaResponse>>> get(
    String token,
  ) async {
    try {
      state = const AsyncLoading();
      final res = await ref.read(panjangPipaRepoProvider).get(token);
      ref.read(setPanjangPipaStateProvider.notifier).state = res;

      if (res.isEmpty) {
        state = const AsyncData([]);
        return const Left([]);
      } else {
        state = AsyncData(res);
        // List<PanjangPipaResponse> data =
        //     ref!.read(setPanjangPipaStateProvider.notifier).state = res;
        // ref!.read(setPanjangPipaProvider(res));
        return Right(res);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
      return const Left([]);
    }
  }
}

final panjangPipaProviders = StateNotifierProvider<PanjangPipaProviders,
    AsyncValue<List<PanjangPipaResponse>>>(
  (ref) => PanjangPipaProviders(ref: ref),
);
