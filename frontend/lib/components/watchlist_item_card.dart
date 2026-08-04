import 'package:flutter/material.dart';
import 'package:frontend/models/watchlist_form_result.dart';
import 'package:frontend/models/watchlist_item.dart';
import 'package:frontend/pages/root_pages/update_watchlist_sheet.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/providers/watchlist_provider.dart';
import 'package:frontend/themes/colors.dart';
import 'package:frontend/themes/text_styles.dart';
import 'package:frontend/utils/watchlist_status_label.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WatchlistItemCard extends StatelessWidget {
  final WatchlistItem watchlistItem;
  final VoidCallback unMarkAsFavorite;
  const WatchlistItemCard({
    super.key,
    required this.watchlistItem,
    required this.unMarkAsFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            GestureDetector(
              onTap: () async {
                final token = context.read<AuthProvider>().token;
                if (token == null) return;

                final result = await showModalBottomSheet<WatchlistFormResult>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) =>
                      UpdateWatchlistSheet(existingItem: watchlistItem),
                );

                if (result == null) return;

                await context.read<WatchlistProvider>().updateWatchlistItem(
                  token,
                  watchlistItem.id,
                  status: result.status,
                  rating: result.rating,
                  notes: result.notes,
                );
              },
              child: SizedBox(
                width: 200,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          watchlistItem.movie.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.sectionTitle,
                        ),
                      ),
                      SizedBox(width: 6),
                      if (watchlistItem.rating != null) ...[
                        _buildRatingStars(watchlistItem.rating!),
                      ],
                    ],
                  ),

                  Text(watchlistItem.movie.releaseYear.toString()),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Added:', style: AppTextStyles.boldText),
                      Text(
                        DateFormat('d MMM y').format(watchlistItem.createdAt),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Updated: ', style: AppTextStyles.boldText),
                      Text(
                        DateFormat('d MMM y').format(watchlistItem.updatedAt),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      if (watchlistItem.notes != null) ...[
                        Text('Notes:', style: AppTextStyles.boldText),
                        Text(watchlistItem.notes!),
                      ],
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status:', style: AppTextStyles.boldText),
                      Text(watchlistStatusLabel(watchlistItem.status)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: AppColors.markFavorite,
          size: 26,
        );
      }),
    );
  }
}
