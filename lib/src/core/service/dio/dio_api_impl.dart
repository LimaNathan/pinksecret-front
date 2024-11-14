import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pinksecret_front/src/core/service/api_service.dart';
import 'package:pinksecret_front/src/shared/utils/constants/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioApiImpl implements ApiService {
  static const String _baseURL = String.fromEnvironment('base_url');

  static const String apiLogger = 'API';
  final _headers = <String, String>{};

  late final Dio _dio = Dio();

  DioApiImpl() {
    _getBearer();
    final dioOptions = BaseOptions(
      baseUrl: _baseURL,
      headers: _headers,
    );
    _dio.options = dioOptions;
  }

  Future<Map<String, String>> _getBearer() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.get(SharedPrefsKeys.token);
    if (token != null) {
      _headers.addAll({'Authorization': 'Bearer $token'});
    }
    return _headers;
  }

  @override
  Future delete(String url, {required int id}) async {
    try {
      final response = await _dio.delete(
        url,
        queryParameters: {
          'id': '$id',
        },
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception();
      }
    } catch (e) {
      log('error deleting data from api: $e', name: apiLogger);
    }
  }

  @override
  Future get(String url, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters:
            (queryParams ?? <String, String>{}) as Map<String, String>,
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception();
      }
    } catch (e) {
      log('error deleting data from api: $e', name: apiLogger);
    }
  }

  @override
  Future post(String url, {dynamic body}) async {
    try {
      final response = await _dio.post(
        url,
        data: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception();
      }
    } catch (e) {
      log('error deleting data from api: $e', name: apiLogger);
    }
  }

  @override
  Future update(String url, {Map<String, dynamic>? body}) async {
    try {
      final response = await _dio.patch(
        url,
        data: body,
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception();
      }
    } catch (e) {
      log('error deleting data from api: $e', name: apiLogger);
    }
  }

  @override
  Future<void> addHeaders(Map<String, String> headers) async {
    _headers.addAll(headers);
  }
}
