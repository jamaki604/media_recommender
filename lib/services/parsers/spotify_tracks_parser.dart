import 'dart:convert';
import 'package:media_recommender/models/track.dart';

class SpotifyTracksParser {
  List<Track> parseTracks(String jsonData) {
    final decoded = jsonDecode(jsonData);
    List<Track> tracks = [];

    for (var trackItem in decoded['tracks']['items']) {
      String name = trackItem['name'];
      String href = trackItem['external_urls']['spotify'];
      String artist = trackItem['artists'][0]['name'];
      tracks.add(Track(name, href, artist));
    }

    return tracks;
  }
}
