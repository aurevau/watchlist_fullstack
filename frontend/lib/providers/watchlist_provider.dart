import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/watchlist_item.dart';
import 'package:frontend/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class WatchlistProvider with ChangeNotifier {
  List<WatchlistItem> _watchlist = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<WatchlistItem> get watchlist => _watchlist;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWatchlist(String token) async {
    _isLoading = true;
    _errorMessage = null;
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());

    try {
      final response = await http.get(
        Uri.parse(watchlistEndpoint),
        headers: {'Authorization': 'Bearer $token'},
      );
      final body = json.decode(response.body);

      if (response.statusCode == 200) {
        final itemsJson = body['data']['watchlistItems'] as List;
        _watchlist = itemsJson.map((i) => WatchlistItem.fromJson(i)).toList();
      } else {
        _errorMessage = body['error'] ?? 'Kunde inte hämta watchlistan';
      }
    } catch (error) {
      _errorMessage = 'Något gick fel $error';
    }

    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
  }

  Future<bool> addToWatchlist(
    String token,
    String movieId, {
    String? status,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(watchlistEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'movieId': movieId,
          if (status != null) 'status': status,
        }),
      );

      if (response.statusCode == 201) {
        await fetchWatchlist(token);
        return true;
      }
    } catch (error) {
      print('kunde inte lägga till i watchlist $error');
      _errorMessage = 'kunde inte lägga till i watchlist $error';
    }
    return false;
  }

  Future<bool> removeFromWatchlist(String token, watchlistItemId) async {
    try {
      final response = await http.delete(
        Uri.parse(deleteFromWatchlistEndpoint(watchlistItemId)),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        _watchlist.removeWhere((item) => item.id == watchlistItemId);
        WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
        return true;
      }
    } catch (error) {
      _errorMessage = 'Kunde inte ta bort från watchlist: $error';
      print('Kunde inte ta bort från watchlist: $error');
    }
    return false;
  }

  Future<bool> updateWatchlistItem(
    String token,
    String watchlistItemId, {
    String? status,
    int? rating,
    String? notes,
  }) async {
    try {
      final response = await http.put(
        Uri.parse(updateWatchlistEndpoint(watchlistItemId)),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          if (status != null) 'status': status,
          if (rating != null) 'rating': rating,
          if (notes != null) 'notes': notes,
        }),
      );

      if (response.statusCode == 200) {
        await fetchWatchlist(token);
        return true;
      }
    } catch (error) {
      _errorMessage = 'Kunde inte uppdatera watchlist-item: $error';
      print('Kunde inte uppdatera watchlist-item: $error');
    }
    return false;
  }

  bool isInWatchlist(String movieId) {
    return _watchlist.any((item) => item.movieId == movieId);
  }

  String? getWatchlistItemId(String movieId) {
    final match = _watchlist.where((item) => item.movieId == movieId);
    return match.isEmpty ? null : match.first.id;
  }
}
