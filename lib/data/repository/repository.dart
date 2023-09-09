import 'dart:convert';
import 'package:http/http.dart';
import 'package:tigasendok/data/model/user_model.dart';

class Repository {
  final baseUrl = 'https://test.goldenmom.id/api';

  Future<UserResponse> userLogin(
      {required String email, required String password}) async {
    final header = {'Content-Type': 'application/json'};
    final body = {'email': email, 'password': password};
    final response = await post(
      Uri.parse('$baseUrl/login'),
      headers: header,
      body: jsonEncode(body),
    );

    final data = jsonDecode(response.body);
    final UserResponse user = UserResponse.fromJson(data);
    return user;
  }

  Future<UserResponse> userRegister({
    required String email,
    required String password,
    required String name,
  }) async {
    final header = {'Content-Type': 'application/json'};
    final body = {
      'email': email,
      'password': password,
      'name': name,
    };
    final response = await post(
      Uri.parse('$baseUrl/register'),
      headers: header,
      body: jsonEncode(body),
    );

    final data = jsonDecode(response.body);
    final UserResponse user = UserResponse.fromJson(data);
    return user;
  }

  Future<UserResponse> userLogOut({required accessToken}) async {
    final header = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    final response = await post(Uri.parse('$baseUrl/logout'), headers: header);

    final data = jsonDecode(response.body);
    final UserResponse user = UserResponse.fromJson(data);
    return user;
  }
}
