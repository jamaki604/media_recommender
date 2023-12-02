import 'media_item.dart';

class Playlist extends MediaItem {
  final String description;

  Playlist(super.name, super.href, this.description);
}
