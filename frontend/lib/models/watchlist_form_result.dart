import 'package:frontend/models/watchlist_item.dart';

class WatchlistFormResult {
  final WatchStatus status;
  final int? rating;
  final String? notes;

  const WatchlistFormResult({required this.status, this.rating, this.notes});
}
