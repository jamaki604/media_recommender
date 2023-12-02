import 'media_item.dart';

class Show extends MediaItem {
  final String description;

  Show(super.name, super.href, this.description);
}
