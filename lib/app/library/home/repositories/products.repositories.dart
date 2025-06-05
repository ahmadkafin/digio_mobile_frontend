import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/response/products.response.dart';

List<ProductsResponse> data = [];

final setProductsStateProvider = StateProvider<List<ProductsResponse>?>(
  (ref) => null,
);

final setProductsProvider = StateProvider.family<void, List<ProductsResponse>>(
  (ref, rootMenuData) {
    ref.watch(setProductsStateProvider);
    data = rootMenuData.isEmpty ? [] : rootMenuData;
  },
);

final getProductsProvider = FutureProvider<List<ProductsResponse>>(
  (ref) async {
    ref.watch(setProductsStateProvider);
    return data;
  },
);
