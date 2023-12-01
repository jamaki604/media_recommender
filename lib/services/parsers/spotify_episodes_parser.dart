import 'dart:convert';
import 'package:media_recommender/models/spotify_search_results.dart';
import 'package:media_recommender/models/episode.dart';

class SpotifyEpisodesParser {
  SpotifySearchResults parseEpisodes(String jsonData) {
    final decoded = jsonDecode(jsonData);
    List<Episode> episodes = [];

    for (var episodeItem in decoded['episodes']['items']) {
      String name = episodeItem['name'];
      String href = episodeItem['external_urls']['spotify'];
      String description = episodeItem['description'];
      episodes.add(Episode(name, href, description));
    }

    return SpotifySearchResults(null, null, null, null, episodes, null, null);
  }
}
