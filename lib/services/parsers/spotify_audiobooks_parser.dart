import 'dart:convert';
import 'package:media_recommender/models/spotify_search_results.dart';
import 'package:media_recommender/models/audiobook.dart';

class SpotifyAudiobooksParser {
  SpotifySearchResults parseAudiobooks(String jsonData) {
    final decoded = jsonDecode(jsonData);
    List<Audiobook> audiobooks = [];

    for (var albumItem in decoded['audiobooks']['items']) {
      String name = albumItem['name'];
      String href = albumItem['external_urls']['spotify'];
      String author = albumItem['authors'][0]['name'];
      String description = albumItem['description'];
      audiobooks.add(Audiobook(name, author, href, description));
    }

    return SpotifySearchResults(null, null, null, audiobooks, null, null, null);
  }
}
