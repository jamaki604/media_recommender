class Album{
  final String _name;
  final String _artist;
  final String _href;

  Album(this._name, this._artist, this._href);

  String get href => _href;

  String get name => _name;

  String get artist => _artist;
}