// import 'dart:developer';
//
// import 'package:dio/dio.dart';
//
// class ApiInterceptors extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     log('===================================================');
//     log('REQUEST[${options.method}] => PATH: ${options.path}');
//     log('${options.data}');
//     super.onRequest(options, handler);
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     log('RESPONSE[${response.statusCode}] => data: ${response.data}');
//     log('===================================================');
//     super.onResponse(response, handler);
//   }
//
//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     log('ERROR[${err.response?.statusCode}] => type: ${err.type}');
//     log('===================================================');
//     super.onError(err, handler);
//   }
// }
