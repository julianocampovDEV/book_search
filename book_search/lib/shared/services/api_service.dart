import 'package:dio/dio.dart';

import 'package:book_search/shared/data/models/rest_config.dart';

class ApiService {
  late Dio client;
  RestConfig restConfig;

  ApiService({required this.restConfig}) {
    client = Dio(
      BaseOptions(
        baseUrl: restConfig.baseUrl,
        headers: restConfig.headers,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
  }

  Future<Response> get({required url, Map<String, String>? headers}) async {
    if (headers != null) client.options.headers.addAll(headers);
    final Response response = await client.get(url);
    return response;
  }
}
