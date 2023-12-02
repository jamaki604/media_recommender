import 'media_item.dart';

class Episode extends MediaItem {
  final String description;

  Episode(super.name, super.href, this.description);
}
