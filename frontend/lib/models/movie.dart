class Movie {
  final String id;
  final String title;
  final String? overview;
  final int releaseYear;
  final List<String> genres;
  final int? runTime;
  final String? posterUrl;
  final String createdBy;
  final DateTime createdAt;

  Movie({
    required this.id,
    required this.title,
    this.overview,
    required this.releaseYear,
    required this.genres,
    this.runTime,
    this.posterUrl,
    required this.createdBy,
    required this.createdAt,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    var genresList = json['genres'] as List? ?? [];

    return Movie(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      overview: json['overview'] as String?,
      releaseYear: json['releaseYear'] as int? ?? 0,
      genres: genresList.map((g) => g.toString()).toList(),
      runTime: json['runTime'] as int?,
      posterUrl: json['posterUrl'] as String?,
      createdBy: json['createdBy'] as String? ?? '',
      createdAt: DateTime.parse(
        json['createdAt'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'releaseYear': releaseYear,
      'genres': genres,
      'runTime': runTime,
      'posterUrl': posterUrl,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
