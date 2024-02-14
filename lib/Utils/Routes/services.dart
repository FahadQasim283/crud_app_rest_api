import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../../Constants/Widgets/constants.dart';

class ApiHandler {
  static Future<bool> deleteById(String id) async {
    Response response =
        await http.delete(Uri.parse('https://api.nstack.in/v1/todos/$id'));
    return response.statusCode == 200;
  }

  static Future<List?> getData() async {
    Response response = await http
        .get(Uri.parse('https://api.nstack.in/v1/todos?page=1&limit=20'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map;
      return Constants.items = data['items'] as List;
    } else {
      return null;
    }
  }
}
