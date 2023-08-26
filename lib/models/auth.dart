import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciamento_de_estado/utils/exceptions/auth_exception.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<void> _authenticate(
      String email, String password, String urlFragment) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyCneiX8S2VLAxCtjodtUiLYx2IRD2oukz0";
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          'email': email,
          'password': password,
          "returnSecureToken": true,
        },
      ),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body["error"]["message"]);
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }
}
