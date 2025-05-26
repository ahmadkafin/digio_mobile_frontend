import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';

List<MenuResponse> data = [];

final setRootMenuStateProvider = StateProvider<List<MenuResponse>?>(
  (ref) => null,
);

final setRootMenuProvider = StateProvider.family<void, List<MenuResponse>>(
  (ref, rootMenuData) {
    ref.watch(setRootMenuStateProvider);
    data = rootMenuData.isEmpty ? [] : rootMenuData;
  },
);

final getRootMenuProvider = FutureProvider<List<MenuResponse>>(
  (ref) async {
    ref.watch(setRootMenuStateProvider);
    return data;
  },
);
