import 'dart:convert';

import 'package:app_store/common/global_variables.dart';
import 'package:app_store/data/models/auth_response_model.dart';
import 'package:app_store/data/models/request/login_request_model.dart';
import 'package:app_store/data/models/request/register_request_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthDataSource {
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel model) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
      Uri.parse('${GlobalVariables.baseUrl}/api/register'),
      headers: headers,
      body: model.toJson(),
    );
    if (response.statusCode == 200) {
      return right(AuthResponseModel.fromJson(response.body));
    } else {
      return left("Server Error");
    }
  }

  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel model) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
      Uri.parse('${GlobalVariables.baseUrl}/api/login'),
      headers: headers,
      body: model.toJson(),
    );
    var obj = jsonDecode(response.body);
    print(obj);
    if (response.statusCode == 200) {
      return right(AuthResponseModel.fromJson(response.body));
    } else {
      final obj = jsonDecode(response.body);
      return left(obj['message']);
    }
  }

  Future<Either<String, String>> logout() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
      Uri.parse('${GlobalVariables.baseUrl}/api/logout'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return right("logout success");
    } else {
      return left('server error');
    }
  }
}
