import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';

List<MenuResponse> data = [];
final setChildMenuStateProvider = StateProvider<List<MenuResponse>?>(
  (ref) => null,
);

final setChildMenuProvider = StateProvider.family<void, List<MenuResponse>>(
  (ref, childMenuData) {
    ref.watch(setChildMenuStateProvider);
    data = childMenuData.isEmpty ? [] : childMenuData;
  },
);

final getChildMenuProvider = FutureProvider<List<MenuResponse>>(
  (ref) async {
    ref.watch(setChildMenuStateProvider);
    return data;
  },
);
