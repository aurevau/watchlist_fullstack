import 'package:flutter/material.dart';
import 'package:frontend/models/watchlist_item.dart';
import 'package:frontend/themes/colors.dart';
import 'package:frontend/themes/text_styles.dart';
import 'package:intl/intl.dart';

class WatchlistItemCard extends StatelessWidget {
  final WatchlistItem watchlistItem;
  final VoidCallback onTap;
  final VoidCallback unMarkAsFavorite;
  const WatchlistItemCard({
    super.key,
    required this.watchlistItem,
    required this.unMarkAsFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
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
                    icon: Icon(Icons.star, color: AppColors.markFavorite),
                    onPressed: () {
                      unMarkAsFavorite();
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: onTap,
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: watchlistItem.movie.posterUrl != null
                        ? Image.network(
                            watchlistItem.movie.posterUrl!,
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
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Title:'),
                        Text(watchlistItem.movie.title),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Release year:'),
                        Text(watchlistItem.movie.releaseYear.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Added to watchlist:'),
                        Text(
                          DateFormat('d MMM y').format(watchlistItem.createdAt),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Updated at: '),
                        Text(
                          DateFormat('d MMM y').format(watchlistItem.updatedAt),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: AppColors.greenStatus,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (watchlistItem.rating != null) ...[
                                Text('Rating:'),
                                SizedBox(width: 12),
                                Text(watchlistItem.rating!.toString()),
                              ],
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (watchlistItem.notes != null) ...[
                                Text('Notes:'),
                                Text(watchlistItem.notes!),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
