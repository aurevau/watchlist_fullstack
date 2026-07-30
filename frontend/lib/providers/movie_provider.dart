import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/movie.dart';
import 'package:frontend/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = [];
  Movie? _selectedMovie;
  bool _isLoading = false;
  String? _errorMessage;

  List<Movie> get movies => _movies;
  Movie? get selectedMovie => _selectedMovie;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> getAllMovies() async {
    _isLoading = true;
    _errorMessage = null;

    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());

    try {
      final response = await http.get(Uri.parse(moviesEndpoint));
      final body = json.decode(response.body);

      if (response.statusCode == 200) {
        final movieJson = body['data']['movies'] as List;
        _movies = movieJson.map((m) => Movie.fromJson(m)).toList();
        _isLoading = false;
        WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
        return true;
      } else {
        _errorMessage = body['error'] ?? 'Kunde inte hämta filmer';
      }
    } catch (error) {
      _errorMessage = 'Något gick fel: $error';
    }

    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
    return false;
  }

  Future<bool> searchMovies(String query) async {
    _isLoading = true;
    _errorMessage = null;
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());

    try {
      final response = await http.get(Uri.parse(searchMoviesEndpoint(query)));
      final body = json.decode(response.body);

      if (response.statusCode == 200) {
        final moviesJson = body['data']['movies'] as List;
        _movies = moviesJson.map((m) => Movie.fromJson(m)).toList();
        _isLoading = false;
        WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
        return true;
      } else {
        _errorMessage = body['error'] ?? 'Sökningen misslyckades';
      }
    } catch (error) {
      _errorMessage = 'Något gick fel: $error';
    }
    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
    return false;
  }

  Future<bool> getMovieById(String id) async {
    _isLoading = true;
    _errorMessage = null;
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());

    try {
      final response = await http.get(Uri.parse(movieDetailEndpoint(id)));
      final body = json.decode(response.body);

      if (response.statusCode == 200) {
        _selectedMovie = Movie.fromJson(body['data']['movie']);
        _isLoading = false;
        WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
        return true;
      } else {
        _errorMessage = body['error'] ?? 'Filmen hittades inte';
      }
    } catch (error) {
      _errorMessage = 'Något gick fel: $error';
    }

    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
    return false;
  }
}
