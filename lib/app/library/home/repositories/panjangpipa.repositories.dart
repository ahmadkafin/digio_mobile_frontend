import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/response/panjangpipa.response.dart';

List<PanjangPipaResponse> data = [];

final setPanjangPipaStateProvider = StateProvider<List<PanjangPipaResponse>?>(
  (ref) => null,
);

final setPanjangPipaProvider =
    StateProvider.family<void, List<PanjangPipaResponse>>(
  (ref, panjangPipaData) {
    ref.watch(setPanjangPipaStateProvider);
    data = panjangPipaData.isEmpty ? [] : panjangPipaData;
  },
);

final getPanjangPipaProvider = FutureProvider<List<PanjangPipaResponse>>(
  (ref) async {
    ref.watch(setPanjangPipaStateProvider);
    return data;
  },
);
