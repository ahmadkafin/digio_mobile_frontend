import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/auth/repositories/authstorage.repositories.dart';
import 'package:myapp/app/library/home/implement/products.implement.dart';
import 'package:myapp/app/library/home/repositories/products.repositories.dart';
import 'package:myapp/app/library/home/response/products.response.dart';

class ProductsProviders
    extends StateNotifier<AsyncValue<List<ProductsResponse>?>> {
  final Ref ref;

  ProductsProviders({required this.ref}) : super(const AsyncValue.loading());

  Future<Either<List<ProductsResponse>, List<ProductsResponse>>> get() async {
    state = const AsyncLoading(); // Tampilkan loading saat mulai fetch

    final storage = ref.read(secureStorageProvider);
    final tokenStr = await storage.read(key: 'authToken');

    if (tokenStr == null || tokenStr.isEmpty) {
      state = const AsyncData(null); // Token tidak ada, set state ke null
      return const Left([]);
    }

    try {
      final res = await ref.read(productsRepoProvider).get(tokenStr);

      // Update state dan local cache (jika pakai)
      state = AsyncData(res);
      ref.read(setProductsStateProvider.notifier).state = res;
      ref.read(setProductsProvider(res));

      if (res.isEmpty) {
        return const Left([]);
      } else {
        return Right(res);
      }
    } catch (e, st) {
      state = AsyncError(e, st); // Tangani error
      return const Left([]);
    }
  }
}

final productsProviders = StateNotifierProvider<ProductsProviders,
    AsyncValue<List<ProductsResponse>?>>(
  (ref) => ProductsProviders(ref: ref),
);
