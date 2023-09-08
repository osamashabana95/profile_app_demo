import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/user.dart';

Future<List<User>> fetchUsers(Map<String, String> pram) async {
  final response = await http.get(
    Uri.https('reqres.in', '/api/users', pram),
  );

  if (response.statusCode == 200) {
    var result = jsonDecode(response.body)["data"].cast<dynamic>();
    var formattedResult =
        result.map<User>((json) => User.fromJson(json)).toList();
    return formattedResult;
  } else {
    throw Exception('Failed to load Users');
  }
}

Future<User> fetchSingleUser(int id) async {
  final response = await http.get(
    Uri.https('reqres.in', '/api/users/$id'),
  );
  if (response.statusCode == 200) {
    var result = jsonDecode(response.body)["data"].cast<String, dynamic>();
    var formattedResult = User.fromJson(result);
    return formattedResult;
  } else {
    throw Exception('Failed to load User');
  }
}
