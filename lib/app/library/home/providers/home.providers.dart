import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/implement/home.implement.dart';
import 'package:myapp/app/library/home/repositories/home.repositories.dart';
import 'package:myapp/app/library/home/response/home.response.dart';

class HomeProviders extends StateNotifier<AsyncValue<dynamic>> {
  Ref? ref;
  HomeProviders({required this.ref}) : super(const AsyncData(null));
  Future<Either<List<HomeResponse>, List<HomeResponse>>> get(
    String token,
  ) async {
    state = const AsyncLoading();
    final res = await ref!.read(homeRepoProvider).get(token);
    if (res.isEmpty) {
      return const Left([]);
    } else {
      List<HomeResponse> data =
          ref!.read(setHomeStateProvider.notifier).state = res;
      ref!.read(setHomeProvider(res));
      return Right(data);
    }
  }
}

final homeProviders = StateNotifierProvider<HomeProviders, AsyncValue<dynamic>>(
  (ref) => HomeProviders(ref: ref),
);
