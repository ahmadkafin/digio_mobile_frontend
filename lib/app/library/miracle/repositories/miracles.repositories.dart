import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/miracle/response/miracles.response.dart';

List<MiraclesResponse> data = [];
final setMiracleStateProvider = StateProvider<List<MiraclesResponse>?>(
  (ref) => null,
);

final setMiracleProvider =
    StateProvider.family<void, List<MiraclesResponse>>((ref, miracleData) {
  ref.watch(setMiracleStateProvider);
  data = miracleData.isEmpty ? [] : miracleData;
});

final getMiracleProvider = FutureProvider<List<MiraclesResponse>>((ref) async {
  ref.watch(setMiracleStateProvider);
  return data;
});
