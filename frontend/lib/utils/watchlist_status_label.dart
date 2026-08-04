import 'package:frontend/models/watchlist_item.dart';

String watchlistStatusLabel(WatchStatus status) {
  final name = status.name;
  return name[0].toUpperCase() + name.substring(1);
}
