import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/implement/detailasset.implement.dart';
import 'package:myapp/app/library/home/repositories/detailasset.repositories.dart';
import 'package:myapp/app/library/home/response/detailasset.response.dart';

class DetailAssetProviders extends StateNotifier<AsyncValue<dynamic>> {
  Ref? ref;

  DetailAssetProviders({required this.ref}) : super(const AsyncData(null));

  Future<Either<List<DetailAssetResponse>, List<DetailAssetResponse>>> get(
    String token,
    String name,
  ) async {
    state = const AsyncLoading();
    final res = await ref!.read(detailAssetRepoProvider).get(token, name);
    if (res.isEmpty) {
      return const Left([]);
    } else {
      List<DetailAssetResponse> data =
          ref!.read(setDetailAssetStateProvider.notifier).state = res;
      return Right(data);
    }
  }
}

final detailAssetProviders =
    StateNotifierProvider<DetailAssetProviders, AsyncValue>(
  (ref) => DetailAssetProviders(ref: ref),
);
