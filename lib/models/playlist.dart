class Playlist{
  final String _name;
  final String _description;
  final String _href;

  Playlist(this._name, this._description, this._href);

  String get href => _href;

  String get description => _description;

  String get name => _name;
}