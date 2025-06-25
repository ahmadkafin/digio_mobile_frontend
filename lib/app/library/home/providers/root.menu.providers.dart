import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/implement/root.menu.implement.dart';
import 'package:myapp/app/library/home/repositories/root.menu.repositories.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';

class RootMenuProviders extends StateNotifier<AsyncValue<List<MenuResponse>>> {
  final Ref ref;

  RootMenuProviders(this.ref) : super(const AsyncLoading());

  Future<Either<List<MenuResponse>, List<MenuResponse>>> get(
    String token,
    String username,
    String directory,
  ) async {
    try {
      state = const AsyncLoading();

      final res =
          await ref.read(rootMenuRepoProvider).get(token, username, directory);

      // simpan ke global state
      ref.read(rootMenuStateProvider.notifier).state = res;

      if (res.isEmpty) {
        state = const AsyncData([]);
        return const Left([]);
      } else {
        state = AsyncData(res);
        return Right(res);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
      return const Left([]);
    }
  }
}

final rootMenuProviders =
    StateNotifierProvider<RootMenuProviders, AsyncValue<List<MenuResponse>>>(
  (ref) => RootMenuProviders(ref),
);
