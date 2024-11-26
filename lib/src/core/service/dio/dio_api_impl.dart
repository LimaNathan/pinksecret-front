import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pinksecret_front/src/core/service/api_service.dart';
import 'package:pinksecret_front/src/core/service/dio/dio_api_inteceptor_impl.dart';
import 'package:pinksecret_front/src/shared/utils/constants/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioApiImpl implements ApiService {
  static const String apiLogger = 'API';
  final _headers = <String, String>{};
  late final Dio _dio;

  DioApiImpl() {
    _getBearer();

    final dioOptions = BaseOptions(
      headers: _headers,
    );
    _dio = Dio();
    addHeaders({'Accept': 'application/json'});

    _dio.interceptors
      ..add(DioApiInteceptorImpl().interceptor)
      ..add(RetryInterceptor(
        dio: _dio,
        retries: 3,
        retryDelays: [Duration(seconds: 2)],
        logPrint: (value) => log(value, name: 'RETRY INTERCEPTOR'),
      ));

    _dio.options = dioOptions;

    log('Cabeçalhos configurados: $_headers', name: apiLogger);
  }

  Future<Map<String, String>> _getBearer() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get(SharedPrefsKeys.token);

    if (token != null) {
      addHeaders({'Authorization': 'Bearer $token'});
      log('Token de autenticação encontrado e adicionado ao cabeçalho.',
          name: apiLogger);
    } else {
      log('Nenhum token de autenticação encontrado. Cabeçalho de autorização não será adicionado.',
          name: apiLogger);
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
        options: Options(
          headers: await _getBearer(),
        ),
      );

      if (response.statusCode == 200) {
        log('Requisição DELETE bem-sucedida. Status: ${response.statusCode}',
            name: apiLogger);
        return response;
      } else {
        log('Falha ao deletar dados. Status da resposta: ${response.statusCode}',
            name: apiLogger);
        throw Exception('Falha ao deletar dados');
      }
    } catch (e) {
      log('Erro ao tentar deletar dados da API: $e', name: apiLogger);
      rethrow;
    }
  }

  @override
  Future get(String url, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: (queryParams ?? <String, String>{}),
        options: Options(
          headers: await _getBearer(),
        ),
      );

      if (response.statusCode == 200) {
        log('Requisição GET bem-sucedida. Status: ${response.statusCode}',
            name: apiLogger);
        return response;
      } else {
        log('Falha ao obter dados. Status da resposta: ${response.statusCode}',
            name: apiLogger);
        throw Exception('Falha ao obter dados');
      }
    } on DioException catch (e) {
      log('Mensagem da API: ${e.error}', name: apiLogger);
      throw Exception('${e.error}');
    } catch (e) {
      log('Erro ao tentar obter dados da API: $e', name: apiLogger);
      rethrow;
    }
  }

  @override
  Future post(String url, {dynamic body}) async {
    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: await _getBearer(),
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Requisição POST bem-sucedida. Status: ${response.statusCode}',
            name: apiLogger);
        return response;
      } else {
        log('Falha ao enviar dados. Status da resposta: ${response.statusCode}',
            name: apiLogger);
        throw Exception('Falha ao enviar dados');
      }
    } catch (e) {
      log('Erro ao tentar enviar dados para a API: $e', name: apiLogger);
      rethrow;
    }
  }

  @override
  Future update(String url, {Map<String, dynamic>? body}) async {
    try {
      final response = await _dio.patch(
        url,
        data: body,
        options: Options(
          headers: await _getBearer(),
        ),
      );

      if (response.statusCode == 200) {
        log('Requisição PATCH bem-sucedida. Status: ${response.statusCode}',
            name: apiLogger);
        return response;
      } else {
        log('Falha ao atualizar dados. Status da resposta: ${response.statusCode}',
            name: apiLogger);
        throw Exception('Falha ao atualizar dados');
      }
    } catch (e) {
      log('Erro ao tentar atualizar dados na API: $e', name: apiLogger);
      rethrow;
    }
  }

  @override
  Future<void> addHeaders(Map<String, String> headers) async {
    _headers.addAll(headers);
    log('Cabeçalhos adicionais adicionados: $headers', name: apiLogger);
  }
}
