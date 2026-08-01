import 'package:frontend/models/movie.dart';

enum WatchStatus { planned, watching, completed, dropped }

WatchStatus watchStatusFromString(String status) {
  switch (status.toUpperCase()) {
    case 'WATCHING':
      return WatchStatus.watching;
    case 'COMPLETED':
      return WatchStatus.completed;
    case 'DROPPED':
      return WatchStatus.dropped;
    default:
      return WatchStatus.planned;
  }
}

String watchStatusToString(WatchStatus status) {
  return status.name.toUpperCase();
}

class WatchlistItem {
  final String id;
  final String userId;
  final String movieId;
  final WatchStatus status;
  final int? rating;
  final String? notes;
  final Movie movie;
  final DateTime createdAt;
  final DateTime updatedAt;

  WatchlistItem({
    required this.id,
    required this.userId,
    required this.movieId,
    required this.status,
    this.rating,
    this.notes,
    required this.movie,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WatchlistItem.fromJson(Map<String, dynamic> json) {
    return WatchlistItem(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      movieId: json['movieId'] as String? ?? '',
      status: watchStatusFromString(json['status'] as String? ?? 'PLANNED'),
      rating: json['rating'] as int?,
      notes: json['notes'] as String?,
      movie: Movie.fromJson(json['movie'] as Map<String, dynamic>),
      createdAt: DateTime.parse(
        json['createdAt'] as String? ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}
