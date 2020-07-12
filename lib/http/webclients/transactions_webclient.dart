import 'dart:convert';

import 'package:bytebank_persistencia/http/webclient.dart';
import 'package:bytebank_persistencia/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(baseURL);
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((e) => Transaction.fromJson(e)).toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJSON = jsonEncode(transaction.toJson());

    await Future.delayed(Duration(seconds: 4));

    final Response response = await client.post(
      baseURL,
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
      body: transactionJSON,
    );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }
    throw HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    if (_mapStatusCodeResponses.containsKey(statusCode)) {
      return _mapStatusCodeResponses[statusCode];
    }
    return 'Unknown Error!';
  }

  static final Map<int, String> _mapStatusCodeResponses = {
    400: 'There was an error submitting transaction',
    401: 'Authentication Failed',
    409: 'Transaction already exists',
    500: 'Unexpected server error',
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
