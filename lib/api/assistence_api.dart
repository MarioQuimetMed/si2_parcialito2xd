import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:si2_parcialito2/models/assistenceResponse.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:si2_parcialito2/models/assistenceVirtualResponse.dart';

class AsistenceApi {
  final String? baseUrl = dotenv.env['BASE_URL'];

  Future<AssistenceResponse> marcarAsistencia(
      int idClase, String codigoQr) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    // print(baseUrl);

    final response = await http.put(
      Uri.parse('$baseUrl/assists/$idClase'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{'codeQr': codigoQr}),
    );

    print(response.body);
    if (response.statusCode == 202 || response.statusCode == 201) {
      // Si el servidor devuelve una respuesta OK, parseamos el JSON.
      return AssistenceResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception('Se debe Marcar Asistencia 10 minutos antes');
    } else {
      // Si la respuesta no es OK, lanzamos un error.
      throw Exception('Fallo al marcar Asistencia');
    }
  }

  Future<AssistenceResponse> marcarAsistenciaVirtual(
      int idClase, String archivoPath) async {
    File file = File(archivoPath);
    String basename = path.basename(file.path);
    var stream = http.ByteStream(file.openRead());
    var length = await file.length();

    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename, contentType: MediaType('image', 'jpeg'));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    // print(baseUrl);

    final request = http.MultipartRequest(
      'PUT',
      Uri.parse('$baseUrl/assists/$idClase/virtual'),
    );

    request.headers.addAll(<String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    });

    request.files.add(multipartFile);
    var response = await request.send();
    var responseBody = await response.stream.transform(utf8.decoder).join();
    // print(response.body);
    print('Hola xd');

    if (response.statusCode == 202 || response.statusCode == 201) {
      // Si el servidor devuelve una respuesta OK, parseamos el JSON.
      return AssistenceResponse.fromJson(jsonDecode(responseBody));
    } else if (response.statusCode == 400) {
      //Manejamos el error del paso del tiempo o antes de tiempo
      final bad = AssistenceVirtualBad.fromJson(jsonDecode(responseBody));
      throw Exception('Error: ${bad.message}');
    } else {
      // Si la respuesta no es OK, lanzamos un error.
      throw Exception('Fallo al marcar Asistencia');
    }
  }

  Future<AssistenceResponse> solicitarLicencia(
      int idClase, String archivoPath) async {
    File file = File(archivoPath);
    String basename = path.basename(file.path);
    var stream = http.ByteStream(file.openRead());
    var length = await file.length();

    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename, contentType: MediaType('image', 'jpeg'));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    // print(baseUrl);

    final request = http.MultipartRequest(
      'PUT',
      Uri.parse('$baseUrl/assists/$idClase/tolerance'),
    );

    request.headers.addAll(<String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    });

    request.files.add(multipartFile);
    var response = await request.send();
    var responseBody = await response.stream.transform(utf8.decoder).join();
    // print(response.body);
    print('Hola xd');

    if (response.statusCode == 202 || response.statusCode == 201) {
      // Si el servidor devuelve una respuesta OK, parseamos el JSON.
      return AssistenceResponse.fromJson(jsonDecode(responseBody));
    } else if (response.statusCode == 400) {
      //Manejamos el error del paso del tiempo o antes de tiempo
      final bad = AssistenceVirtualBad.fromJson(jsonDecode(responseBody));
      throw Exception('Error: ${bad.message}');
    } else {
      // Si la respuesta no es OK, lanzamos un error.
      throw Exception('Fallo al Solicitar Licencia');
    }
  }
}
