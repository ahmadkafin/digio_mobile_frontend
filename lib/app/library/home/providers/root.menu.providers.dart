import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/implement/root.menu.implement.dart';
import 'package:myapp/app/library/home/repositories/root.menu.repositories.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';

class RootMenuProviders extends StateNotifier<AsyncValue<dynamic>> {
  Ref? ref;

  RootMenuProviders({required this.ref}) : super(const AsyncData(null));

  Future<Either<List<MenuResponse>, List<MenuResponse>>> get(
    String token,
  ) async {
    state = const AsyncLoading();
    final res = await ref!.read(rootMenuRepoProvider).get(token);
    if (res.isEmpty) {
      return const Left([]);
    } else {
      List<MenuResponse> data =
          ref!.read(setRootMenuStateProvider.notifier).state = res;
      ref!.read(setRootMenuProvider(res));
      return Right(data);
    }
  }
}

final rootMenuProviders =
    StateNotifierProvider<RootMenuProviders, AsyncValue<dynamic>>(
  (ref) {
    return RootMenuProviders(ref: ref);
  },
);
