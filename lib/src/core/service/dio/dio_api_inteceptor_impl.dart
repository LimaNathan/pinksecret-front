import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pinksecret_front/src/core/service/api_interceptor.dart';
import 'package:pinksecret_front/src/features/auth/interactor/atoms/auth_atoms.dart';

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
          if (statusCode == 401) loggoutAction.call();

          return handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: Exception(errorMessage),
            ),
          );
        },
      );
  String _getMessage(DioException error, int? statusCode) {
    final String? message = error.response?.data['message'];

    return switch (error.type) {
      DioExceptionType.connectionTimeout => message ??
          'Parece que a conexão está demorando mais do que o esperado. Tente novamente em alguns instantes.',
      DioExceptionType.sendTimeout => message ??
          'O envio dos dados demorou demais. Verifique sua conexão e tente novamente.',
      DioExceptionType.receiveTimeout => message ??
          'Não conseguimos obter uma resposta a tempo. Por favor, verifique sua conexão e tente novamente.',
      DioExceptionType.badCertificate => message ??
          'Houve um problema de segurança com o certificado. Tente mais tarde.',
      DioExceptionType.badResponse => switch (statusCode) {
          400 => message ??
              'A requisição não foi entendida. Verifique os dados e tente novamente.',
          401 => message ??
              'Você não tem permissão para acessar este recurso. Por favor, verifique suas credenciais.',
          403 => message ??
              'Você não tem acesso a esta área. Entre em contato com o suporte.',
          404 => message ??
              'Não encontramos o que você procurava. Pode ser que o recurso tenha sido removido ou não exista.',
          500 => message ??
              'Ocorreu um erro interno no servidor. Tente novamente mais tarde.',
          _ => message ??
              'Ocorreu um erro inesperado. Tente novamente ou entre em contato com o suporte.',
        },
      DioExceptionType.cancel => message ??
          'A requisição foi cancelada. Verifique sua conexão ou tente novamente.',
      DioExceptionType.connectionError => message ??
          'Houve um problema de conexão. Verifique sua internet e tente novamente.',
      DioExceptionType.unknown => message ??
          'Algo deu errado. Tente novamente ou entre em contato com o suporte.',
    };
  }
}
