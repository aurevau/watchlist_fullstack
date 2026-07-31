import 'package:flutter/material.dart';
import 'package:frontend/components/input_text_field.dart';
import 'package:frontend/components/movie_card.dart';
import 'package:frontend/models/movie.dart';
import 'package:frontend/pages/root_pages/movie_detail_page.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/providers/movie_provider.dart';
import 'package:frontend/providers/watchlist_provider.dart';
import 'package:frontend/themes/text_styles.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final ScrollController controller;
  const HomePage({Key? key, required this.controller}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieProvider>(context, listen: false).getAllMovies();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String query) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    if (query.trim().isEmpty) {
      movieProvider.getAllMovies();
    } else {
      movieProvider.searchMovies(query.trim());
    }
  }

  // const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [Text('Hem', style: AppTextStyles.pageTitle)]),
      ),
      body: SingleChildScrollView(
        controller: widget.controller,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Upptäck filmer', style: AppTextStyles.pageTitle),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: InputTextField(
                      hintText: 'Sök efter filmer...',
                      isPassword: false,
                      controller: _searchController,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => _onSearchSubmitted(_searchController.text),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              if (movieProvider.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (movieProvider.errorMessage != null)
                Center(child: Text(movieProvider.errorMessage!))
              else if (movieProvider.movies.isEmpty)
                const Center(child: Text('Inga filmer hittades'))
              else
                _buildMovieGrid(movieProvider.movies),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieGrid(List<Movie> movies) {
    final token = Provider.of<AuthProvider>(context, listen: false).token;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.55,
      ),
      itemBuilder: (_, i) {
        final movie = movies[i];
        return MovieCard(
          movie: movie,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MovieDetailPage(movieId: movie.id),
            ),
          ),
        );
      },
    );
  }
}
