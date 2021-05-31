import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siteica_user/models/encounter.dart';

class ApiService {
  Future<http.Response> createNotification(String otpValue, int diagnosticDate) {
    return http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        // 'title': otpValue,
      }),
    );
  }

  Future<http.Response> uploadEncounters(List<Encounter> _encounters) {
    return http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        // 'title': otpValue,
      }),
    );
  }

}