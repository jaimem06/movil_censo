import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movil_censo/models/ResponseGeneric.dart';

class Connection {
  final String urlBase = "http://192.168.1.9:5000/";
  static String urlMedia = "http://192.168.1.9:5000/media";

  Future<ResponseGeneric> get(String resource) async {
    final String url = urlBase + resource;
    Map<String, String> headers = {'Content-Type': "application/json"};
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return _response(body['code'].toString(), body['msg'], body['map']);
    } else {
      throw Exception('Failed to load data');
    }
  }

  ResponseGeneric _response(String code, String msg, Map<String, dynamic> map) {
    var response = ResponseGeneric();
    response.msg = msg;
    response.code = code;
    response.datos = map;
    return response;
  }

  Future<ResponseGeneric> post(
      String resource, Map<String, dynamic> data) async {
    final String url = urlBase + resource;
    Map<String, String> headers = {'Content-Type': "application/json"};
    final uri = Uri.parse(url);
    final response =
        await http.post(uri, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      // Verifica si el cuerpo de la respuesta es null o no contiene los campos esperados
      final body = jsonDecode(response.body);
      if (body == null ||
          !body.containsKey('code') ||
          !body.containsKey('msg') ||
          !body.containsKey('datos')) {
        throw Exception('Respuesta inesperada del servidor');
      }
      Map<String, dynamic> datos =
          body['datos'] != null ? Map<String, dynamic>.from(body['datos']) : {};
      return _response(body['code'].toString(), body['msg'], datos);
    } else {
      throw Exception('Failed to post data');
    }
  }
}
