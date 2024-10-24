import 'dart:developer';

import 'package:pinksecret_front/src/core/service/api_service.dart';
import 'package:pinksecret_front/src/shared/utils/constants/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uno/uno.dart';

class UnoImpl implements ApiService {
  static const String _baseURL = String.fromEnvironment('base_url');

  static const String apiLogger = 'API';
  final _headers = <String, String>{};

  late final Uno _uno = Uno(
    baseURL: _baseURL,
  );

  UnoImpl() {
    _getBearer();
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
      final response = await _uno.delete(url,
          params: {
            'id': '$id',
          },
          headers: _headers);

      if (response.status == 200) {
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
      final response = await _uno.get(
        url,
        params: (queryParams ?? <String, String>{}) as Map<String, String>,
        headers: _headers,
      );
      if (response.status == 200) {
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
      final response = await _uno.post(url, data: body, headers: _headers);

      if (response.status == 200 || response.status == 201) {
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
      final response = await _uno.patch(url, data: body, headers: _headers);
      if (response.status == 200) {
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
