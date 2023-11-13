class Track {
  final String _name;
  final String _href;
  final String _artist;

  Track(this._name, this._href, this._artist);

  String get name => _name;

  String get href => _href;

  String get artist => _artist;
}