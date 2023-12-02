import 'media_item.dart';

class Track extends MediaItem {
  final String artist;

  Track(super.name, super.href, this.artist);
}
