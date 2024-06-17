import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:si2_parcialito2/models/AuthResponse.dart';

class AuthApi {
  final String? baseUrl = dotenv.env['BASE_URL'];

  Future<AuthResponse> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final tokenFMC = prefs.getString('FCMtoken');
    print(baseUrl);
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'tokenFMC': tokenFMC!
      }),
    );

    print(response.body);
    if (response.statusCode == 202 || response.statusCode == 201) {
      // Si el servidor devuelve una respuesta OK, parseamos el JSON.
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      // Si la respuesta no es OK, lanzamos un error.
      var responseBody = jsonDecode(response.body);
      throw Exception(responseBody['message'][0]);
    }
  }
}
