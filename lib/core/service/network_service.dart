import 'dart:developer';

import 'package:dio/dio.dart';
import '../exceptions/connection_exception.dart';

abstract class NetworkService {
  Future<Response> get(String url, {Map<String, dynamic>? queryParameters});
}

class NetworkServiceImpl implements NetworkService {
  final Dio _dio = Dio(BaseOptions(
    validateStatus: (_) => true,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  @override
  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      log('GET $url\nResponse: ${response.statusCode}\nData: ${response.data}');
      return response;
    } catch (e) {
      throw ConnectionException(e.toString());
    }
  }
}
