import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';

/// StateProvider sebagai sumber data utama
final rootMenuStateProvider = StateProvider<List<MenuResponse>>((ref) => []);

/// Provider pembaca (bisa langsung pakai [rootMenuStateProvider] juga jika tidak perlu memisahkan)
final getRootMenuProvider = Provider<List<MenuResponse>>(
  (ref) => ref.watch(rootMenuStateProvider),
);

/// Cara penggunaan di kode lain:
///
/// Menulis data:
/// ref.read(rootMenuStateProvider.notifier).state = yourMenuList;
///
/// Membaca data:
/// final menus = ref.watch(getRootMenuProvider);
