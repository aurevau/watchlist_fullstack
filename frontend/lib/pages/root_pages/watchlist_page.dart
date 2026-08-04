import 'package:flutter/material.dart';
import 'package:frontend/components/watchlist_item_card.dart';
import 'package:frontend/models/watchlist_item.dart';
import 'package:frontend/pages/root_pages/movie_detail_page.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/providers/watchlist_provider.dart';
import 'package:frontend/themes/text_styles.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  final ScrollController controller;
  const WatchlistPage({super.key, required this.controller});

  @override
  State<WatchlistPage> createState() => WatchlistPageState();
}

class WatchlistPageState extends State<WatchlistPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      if (token != null) {
        Provider.of<WatchlistProvider>(
          context,
          listen: false,
        ).fetchWatchlist(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final watchlistProvider = Provider.of<WatchlistProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [Text("Watchlist", style: AppTextStyles.pageTitle)],
        ),
      ),
      body: SingleChildScrollView(
        controller: widget.controller,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (watchlistProvider.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (watchlistProvider.errorMessage != null)
                Center(child: Text(watchlistProvider.errorMessage!))
              else if (watchlistProvider.watchlist.isEmpty)
                const Center(child: Text('Din watchlist är tom'))
              else
                _buildWatchlistGrid(watchlistProvider.watchlist),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWatchlistGrid(List<WatchlistItem> movies) {
    final token = Provider.of<AuthProvider>(context, listen: false).token;
    return GridView.builder(
      itemCount: movies.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 4,
        mainAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (_, i) {
        final movie = movies[i];
        return WatchlistItemCard(
          watchlistItem: movie,
          unMarkAsFavorite: () {
            if (token != null) {
              Provider.of<WatchlistProvider>(
                context,
                listen: false,
              ).removeFromWatchlist(token, movie.id);
            }
          },
        );
      },
    );
  }
}
