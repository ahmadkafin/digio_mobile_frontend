import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/implement/child.menu.implement.dart';
import 'package:myapp/app/library/home/repositories/child.menu.repositories.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';

class ChildMenuProviders extends StateNotifier<AsyncValue<dynamic>> {
  Ref? ref;

  ChildMenuProviders({required this.ref}) : super(const AsyncData(null));

  Future<Either<List<MenuResponse>, List<MenuResponse>>> get(
    String token,
    String parrentid,
  ) async {
    state = const AsyncLoading();
    final res = await ref!.read(childMenuRepoProvider).get(token, parrentid);
    if (res.isEmpty) {
      return const Left([]);
    } else {
      List<MenuResponse> data =
          ref!.read(setChildMenuStateProvider.notifier).state = res;
      ref!.read(setChildMenuProvider(res));
      return Right(data);
    }
  }
}

final childMenuProviders =
    StateNotifierProvider<ChildMenuProviders, AsyncValue<dynamic>>(
  (ref) {
    return ChildMenuProviders(ref: ref);
  },
);
