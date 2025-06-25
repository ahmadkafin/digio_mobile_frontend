import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/splashscreen/implements/splashscreen.implments.dart';
import 'package:myapp/app/library/splashscreen/repositories/splashscreen.repositories.dart';

class SplashScreenProviders extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;

  SplashScreenProviders({required this.ref}) : super(const AsyncLoading());

  Future<void> get() async {
    try {
      state = const AsyncLoading();
      final storage = ref.read(secureStorageProvider);
      final tokenStr = await storage.read(key: 'authToken');

      // await Future.delayed(const Duration(seconds: 1));
      if (tokenStr == null || tokenStr.isEmpty) {
        state = const AsyncValue.data(false);
        ref.read(splashScreenResultProvider.notifier).state = false;
        return;
      }

      final res =
          await ref.read(splashScreenRepoProvider).checkInitState(tokenStr);

      if (!res) {
        storage.delete(key: 'isAuthKey');
      }

      // simpan hasil ke state async
      state = AsyncValue.data(res);
      // simpan hasil ke global state lain jika ingin dipakai oleh widget lainnya
      ref.read(splashScreenResultProvider.notifier).state = res;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final splashScreenProviders =
    StateNotifierProvider<SplashScreenProviders, AsyncValue<bool>>(
  (ref) => SplashScreenProviders(ref: ref),
);
