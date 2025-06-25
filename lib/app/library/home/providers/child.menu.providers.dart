import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/home/implement/child.menu.implement.dart';
import 'package:myapp/app/library/home/repositories/child.menu.repositories.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';

/// Refactored ChildMenuProviders to maintain a cache of menu data per parentId
class ChildMenuProviders
    extends StateNotifier<Map<String, List<MenuResponse>>> {
  final Ref ref;

  ChildMenuProviders(this.ref) : super({});

  /// Fetches and caches menu data based on parentId
  Future<Either<List<MenuResponse>, List<MenuResponse>>> get(
    String token,
    String username,
    String directory,
    String parentId,
  ) async {
    final res = await ref
        .read(childMenuRepoProvider)
        .get(token, username, directory, parentId);

    // Update the state by adding or replacing entry for this parentId
    state = {
      ...state,
      parentId: res,
    };

    if (res.isEmpty) {
      return const Left([]);
    } else {
      return Right(res);
    }
  }

  /// Retrieves cached menu data for a specific parentId
  List<MenuResponse> getData(String parentId) {
    return state[parentId] ?? [];
  }
}

final childMenuProviders =
    StateNotifierProvider<ChildMenuProviders, Map<String, List<MenuResponse>>>(
  (ref) => ChildMenuProviders(ref),
);
