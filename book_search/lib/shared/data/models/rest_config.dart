import 'package:flutter_dotenv/flutter_dotenv.dart';

class RestConfig {
  final String baseUrl = dotenv.get("BASE_URL");

  late Map<String, String> headers;

  RestConfig() {
    _setDefaultHeaders();
  }

  _setDefaultHeaders() {
    headers = {};
  }

  addHeader(String key, String value) {
    headers[key] = value;
  }
}
