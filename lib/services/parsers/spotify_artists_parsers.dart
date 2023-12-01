import 'dart:convert';
import 'package:media_recommender/models/spotify_search_results.dart';
import 'package:media_recommender/models/artist.dart';

class SpotifyArtistsParser {
  SpotifySearchResults parseArtists(String jsonData) {
    final decoded = jsonDecode(jsonData);
    List<Artist> artists = [];
    for (var artistItem in decoded['artists']['items']) {
      String name = artistItem['name'];
      String href = artistItem['external_urls']['spotify'];
      artists.add(Artist(name, href));
    }

    return SpotifySearchResults(null, null, artists, null, null, null, null);
  }
}
