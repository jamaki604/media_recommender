class Audiobook{
  final String _name;
  final String _author;
  final String _href;
  final String _description;


  Audiobook(this._name, this._author, this._href, this._description);

  String get name => _name;

  String get description => _description;

  String get href => _href;

  String get author => _author;
}