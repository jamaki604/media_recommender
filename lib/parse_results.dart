import 'package:media_recommender/track.dart';


class ParseResult{
  final List<Track> _tracks;

  ParseResult(this._tracks);

  List<Track> get tracks => _tracks;
}