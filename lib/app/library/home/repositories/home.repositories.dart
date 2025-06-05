import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/response/home.response.dart';

List<HomeResponse> data = [];

final setHomeStateProvider = StateProvider<List<HomeResponse>?>(
  (ref) => null,
);

final setHomeProvider = StateProvider.family<void, List<HomeResponse>>(
  (ref, homeData) {
    ref.watch(setHomeStateProvider);
    data = homeData.isEmpty ? [] : homeData;
  },
);

final getHomeProvider = FutureProvider<List<HomeResponse>>(
  (ref) async {
    ref.watch(setHomeStateProvider);
    return data;
  },
);
