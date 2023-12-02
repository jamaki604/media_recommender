import 'media_item.dart';

class Audiobook extends MediaItem {
  final String author;
  final String description;

  Audiobook(super.name, super.href, this.author, this.description);
}
