import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/implement/products.implement.dart';
import 'package:myapp/app/library/home/repositories/products.repositories.dart';
import 'package:myapp/app/library/home/response/products.response.dart';

class ProductsProviders extends StateNotifier<AsyncValue<dynamic>> {
  Ref? ref;

  ProductsProviders({required this.ref}) : super(const AsyncData(null));

  Future<Either<List<ProductsResponse>, List<ProductsResponse>>> get(
    String token,
  ) async {
    state = const AsyncLoading();
    final res = await ref!.read(productsRepoProvider).get(token);
    if (res.isEmpty) {
      return const Left([]);
    } else {
      List<ProductsResponse> data =
          ref!.read(setProductsStateProvider.notifier).state = res;
      ref!.read(setProductsProvider(res));
      return Right(data);
    }
  }
}

final productsProviders =
    StateNotifierProvider<ProductsProviders, AsyncValue<dynamic>>(
  (ref) {
    return ProductsProviders(ref: ref);
  },
);
