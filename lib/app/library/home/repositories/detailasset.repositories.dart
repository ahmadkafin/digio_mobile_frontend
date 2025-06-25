import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/response/detailasset.response.dart';

List<DetailAssetResponse> data = [];

final setDetailAssetStateProvider = StateProvider<List<DetailAssetResponse>?>(
  (ref) => null,
);

final setDetailAssetProvider =
    StateProvider.family<void, List<DetailAssetResponse>>(
  (ref, detailAssetData) {
    ref.watch(setDetailAssetStateProvider);
    data = detailAssetData.isEmpty ? [] : detailAssetData;
  },
);

final getDetailProvider = FutureProvider<List<DetailAssetResponse>>(
  (ref) async {
    ref.watch(setDetailAssetStateProvider);
    return data;
  },
);
