import 'dart:convert';

import 'package:media_recommender/parse_results.dart';
import 'package:media_recommender/track.dart';

class SpotifyQueryParser {

  ParseResult parseJson(String jsonData) {
    final decoded = jsonDecode(jsonData);
    List<Track> tracks = [];

    if (decoded['tracks'] != null &&
        decoded['tracks']['items'] != null &&
        decoded['tracks']['items'].isNotEmpty) {
      for (var trackItem in decoded['tracks']['items']) {
        tracks.add(Track(trackItem['name']));
      }
    }

    return ParseResult(tracks);
  }


}
