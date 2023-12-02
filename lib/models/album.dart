import 'media_item.dart';

class Album extends MediaItem {
  final String artist;

  Album(super.name, super.href, this.artist);
}
