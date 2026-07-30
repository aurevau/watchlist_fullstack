import 'package:flutter/material.dart';
import 'package:frontend/providers/movie_provider.dart';
import 'package:frontend/themes/text_styles.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  final String movieId;
  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieProvider>(
        context,
        listen: false,
      ).getMovieById(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    if (movieProvider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final movie = movieProvider.selectedMovie;
    if (movie == null) {
      return const Scaffold(
        body: Center(child: Text('Filmen kunde inte hittas')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (movie.posterUrl != null)
              Image.network(
                movie.posterUrl!,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.movie, size: 40),
                  );
                },
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: AppTextStyles.pageTitle),
                  Text('${movie.releaseYear}'),
                  if (movie.overview != null) ...[
                    const SizedBox(height: 12),
                    Text(movie.overview!),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
