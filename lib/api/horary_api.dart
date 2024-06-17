import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:si2_parcialito2/models/classResponse.dart';
import 'package:si2_parcialito2/models/horaryResponse.dart';
import 'package:http/http.dart' as http;
import 'package:si2_parcialito2/models/matterResponse.dart';

class HoraryApi {
  final String? baseUrl = dotenv.env['BASE_URL'];

  Future<HoraryResponse> getHorary() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getInt('id');

    final response = await http.get(
      Uri.parse('$baseUrl/horary/$id/days'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token', // Aquí agregas el Bearer token
      },
    );

    print(response.body);
    if (response.statusCode == 202 || response.statusCode == 200) {
      // Si el servidor devuelve una respuesta OK, parseamos el JSON.
      final respuesta = HoraryResponse.fromJson(jsonDecode(response.body));
      print(respuesta);
      return respuesta;
    } else {
      // Si la respuesta no es OK, lanzamos un error.

      throw Exception('Failed to login.');
    }
  }

  Future<MatterResponse> getMatters() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getInt('id');

    final response = await http.get(
      Uri.parse('$baseUrl/horary/$id/matter'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token', // Aquí agregas el Bearer token
      },
    );

    print(response.body);
    if (response.statusCode == 202 || response.statusCode == 200) {
      // Si el servidor devuelve una respuesta OK, parseamos el JSON.
      return MatterResponse.fromJson(jsonDecode(response.body));
    } else {
      // Si la respuesta no es OK, lanzamos un error.

      throw Exception('Failed to login.');
    }
  }

  Future<ClassResponse> getClass() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getInt('id');
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/assists/$id/class'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', // Aquí agregas el Bearer token
        },
      );
      final data = ClassResponse.fromJson(jsonDecode(response.body));
      print(response.body);
      if ((data.statusCode == 202 || data.statusCode == 200) &&
          data.data.assists.isNotEmpty) {
        // Si el servidor devuelve una respuesta OK, parseamos el JSON.
        return data;
      } else {
        // Si la respuesta no es OK, lanzamos un error.

        throw Exception('Error al obtener Clases xd');
      }
    } catch (e) {
      print(e);
      throw Exception('Error al obtener Clases xd');
    }
  }
}
