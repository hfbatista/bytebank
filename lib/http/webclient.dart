import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'interceptors/logging_interceptors.dart';

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 5),
);

// TODO: Colocar seu IP Aqui! Ex: 000.000.0.0:0000
const String baseURL = 'http://seu_ip/transactions';