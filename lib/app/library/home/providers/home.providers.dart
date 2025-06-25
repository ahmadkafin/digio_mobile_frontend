import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/implement/home.implement.dart';
import 'package:myapp/app/library/home/repositories/home.repositories.dart';
import 'package:myapp/app/library/home/response/home.response.dart';

class HomeProviders extends StateNotifier<AsyncValue<List<HomeResponse>>> {
  final Ref ref;
  HomeProviders({required this.ref}) : super(const AsyncLoading());

  Future<void> get(String token) async {
    try {
      state = const AsyncLoading();
      final res = await ref.read(homeRepoProvider).get(token);
      state = AsyncValue.data(res);
      // Optional: sync to global state
      ref.read(setHomeStateProvider.notifier).state = res;
      ref.read(setHomeProvider(res));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final homeProviders =
    StateNotifierProvider<HomeProviders, AsyncValue<List<HomeResponse>>>(
  (ref) => HomeProviders(ref: ref),
);
