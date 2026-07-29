import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  String? _token;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  String? get token => _token;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _user != null && _token != null;

  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;

    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());

    try {
      final response = await http.post(
        Uri.parse(registerEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'email': email, 'password': password}),
      );

      final body = json.decode(response.body);

      if (response.statusCode == 201) {
        _user = User.fromJson(body['data']['user']);
        _token = body['data']['token'];
        await _saveToken(_token!);
        _isLoading = false;

        WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
        return true;
      } else {
        _errorMessage = body['error'] ?? 'Registrering misslyckades';
      }
    } catch (error) {
      _errorMessage = 'Något gick fel: $error';
    }

    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
    return false;
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());

    try {
      final response = await http.post(
        Uri.parse(loginEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      final body = json.decode(response.body);

      if (response.statusCode == 201) {
        _user = User.fromJson(body['data']['user']);
        _token = body['data']['token'];
        await _saveToken(_token!);
        _isLoading = false;
        WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
        return true;
      } else {
        _errorMessage = body['error'] ?? 'Fel e-post eller lösenord';
      }
    } catch (error) {
      _errorMessage = 'Något gick fel: $error';
    }

    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
    return false;
  }

  Future<void> logout() async {
    try {
      await http.post(
        Uri.parse(logoutEndpoint),
        headers: {'Authorization': 'Bearer $_token'},
      );
    } catch (error) {
      print('Logout anropet misslyckades: $error');
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
}
