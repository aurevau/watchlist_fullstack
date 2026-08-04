import 'dart:convert';

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

    notifyListeners();
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

        notifyListeners();

        return true;
      } else {
        _errorMessage = body['error'] ?? 'Registrering misslyckades';
      }
    } catch (error) {
      _errorMessage = 'Något gick fel: $error';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;

    notifyListeners();

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
        await refreshUser();
        _isLoading = false;

        notifyListeners();
        return true;
      } else {
        _errorMessage = body['error'] ?? 'Fel e-post eller lösenord';
      }
    } catch (error) {
      _errorMessage = 'Något gick fel: $error';
    }

    _isLoading = false;
    notifyListeners();
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
    _user = null;
    _token = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    notifyListeners();
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('auth_token');
    if (savedToken == null) return;

    try {
      print('Requesting URL: $meEndpoint');
      final response = await http.get(
        Uri.parse(meEndpoint),
        headers: {'Authorization': 'Bearer $savedToken'},
      );

      final body = json.decode(response.body);
      if (response.statusCode == 200) {
        _user = User.fromJson(body['data']['user']);
        _token = savedToken;
      } else {
        _errorMessage = body['error'] ?? "Token ogiltig eller utgången";
        print('Auto-login status: ${response.statusCode}');
        print('Auto-login body: ${response.body}');
      }
    } catch (error) {
      _errorMessage = '$error: Token ogiltig eller utgången';

      print('Autologin misslyckades: $error');
    }

    notifyListeners();
  }

  Future<void> refreshUser() async {
    if (_token == null) return;

    try {
      final response = await http.get(
        Uri.parse(meEndpoint),
        headers: {'Authorization': 'Bearer $_token'},
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        _user = User.fromJson(body['data']['user']);
      }
    } catch (error) {
      print('Kunde inte uppdatera användardata: $error');
    }

    notifyListeners();
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
}
