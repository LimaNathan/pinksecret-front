import 'dart:developer';

import 'package:pinksecret_front/src/core/service/api_interceptor.dart';
import 'package:dio/dio.dart';

class DioApiInteceptorImpl implements ApiInterceptor<Interceptor> {


  @override
  get interceptor => InterceptorsWrapper(
        onRequest: (options, handler) {
          log(
            'REQUEST PATH: ${options.path}',
            name: 'REQUEST INTECEPTOR',
          );

          return handler.next(options);
        },
        onResponse: (response, handler) {
          log(
            '[${response.statusCode}] - ${response.realUri}',
            name: 'RESPONSE INTERCEPTOR',
          );

          return handler.next(response);
        },
        onError: (DioException error, handler) {
          if (error.response != null) {
            log(
              '[${error.response?.statusCode}] - ${error.response?.data}',
              name: 'ERROR INTERCEPTOR',
            );
          } else {
            log(
              'Sem resposta do servidor |'
              ' [${error.response?.statusCode}]'
              ' - ${error.response?.data}',
              name: 'ERROR INTERCEPTOR',
            );
          }
          final statusCode = error.response?.statusCode;
          final errorMessage = _getMessage(error, statusCode);

          return handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: Exception(errorMessage),
            ),
          );
        },
      );

  String _getMessage(DioException error, int? statusCode) {
    final String? message = error.response?.data['detailMessage'];
    return switch (error.type) {
      DioExceptionType.connectionTimeout =>
        message ?? 'Erro: Tempo de conexão esgotado',
      DioExceptionType.sendTimeout =>
        message ?? 'Erro: Tempo de envio esgotado',
      DioExceptionType.receiveTimeout =>
        message ?? 'Erro: Tempo de resposta esgotado',
      DioExceptionType.badCertificate =>
        message ?? 'Erro: Certificado incorreto',
      DioExceptionType.badResponse => switch (statusCode) {
          400 => message ?? 'Erro 400: Requisição inválida',
          401 => message ?? 'Erro 401: Não autorizado',
          403 => message ?? 'Erro 403: Acesso proibido',
          404 => message ?? 'Erro 404: Recurso não encontrado',
          500 => message ?? 'Erro 500: Erro interno do servidor',
          _ => message ?? 'Erro desconhecido: $statusCode',
        },
      DioExceptionType.cancel => message ?? 'Erro: Requisição cancelada',
      DioExceptionType.connectionError =>
        message ?? 'Erro: Problema de conexão ou outro erro de rede',
      DioExceptionType.unknown =>
        message ?? 'Erro desconhecido: ${error.error}',
    };
  }
}
