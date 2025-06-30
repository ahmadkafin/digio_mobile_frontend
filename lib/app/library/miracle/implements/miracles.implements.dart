import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/library/miracle/response/miracles.response.dart';
import 'package:myapp/core/utils/endpoint.utils.dart';

abstract class MiraclesImplements {
  Future<List<MiraclesResponse>?> get(
    String token,
    String parentMenuId,
    String name,
  );
}

class MiraclesRepoImplement implements MiraclesImplements {
  final Dio dio;
  List<MiraclesResponse>? data;

  MiraclesRepoImplement()
      : dio = Dio(
          BaseOptions(
            baseUrl: url,
            responseType: ResponseType.json,
          ),
        );

  @override
  Future<List<MiraclesResponse>?> get(
    String token,
    String parentMenuId,
    String name,
  ) async {
    try {
      Response response = await dio.post(
        'miracle/get',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {"parent_menu_id": parentMenuId, "name": name},
      );
      print(parentMenuId);
      print(name);

      if (response.statusCode != 200) return null;
      data = response.data['data']
          .map<MiraclesResponse>((json) => MiraclesResponse.fromJson(json))
          .toList();
      return data;
    } on DioException catch (err) {
      debugPrint(err.message);
      return null;
    }
  }
}

final miraclesRepoProvider =
    Provider<MiraclesRepoImplement>((ref) => MiraclesRepoImplement());
