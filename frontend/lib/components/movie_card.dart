import 'package:flutter/material.dart';
import 'package:frontend/models/movie.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/providers/watchlist_provider.dart';
import 'package:frontend/themes/colors.dart';
import 'package:frontend/themes/text_styles.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieCard({super.key, required this.onTap, required this.movie});

  @override
  Widget build(BuildContext context) {
    final watchlistProvider = context.watch<WatchlistProvider>();
    final isSaved = watchlistProvider.isInWatchlist(movie.id);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: AppColors.primary, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        isSaved ? Icons.star : Icons.star_border,
                        color: isSaved
                            ? AppColors.markFavorite
                            : AppColors.textColor,
                      ),
                      onPressed: () async {
                        final token = context.read<AuthProvider>().token;
                        if (token == null) return;
                        final itemId = watchlistProvider.getWatchlistItemId(
                          movie.id,
                        );
                        if (itemId != null) {
                          await watchlistProvider.removeFromWatchlist(
                            token,
                            itemId,
                          );
                        } else {
                          await watchlistProvider.addToWatchlist(
                            token,
                            movie.id,
                          );
                        }
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: movie.posterUrl != null
                        ? Image.network(
                            movie.posterUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.movie, size: 40),
                              );
                            },
                          )
                        : Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.movie, size: 40),
                          ),
                  ),
                ),
                SizedBox(height: 8),

                Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.buttonTextBlack,
                ),
                Text(
                  movie.releaseYear.toString(),
                  style: AppTextStyles.buttonTextBlack,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
