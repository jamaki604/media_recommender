import 'dart:convert';
import 'package:media_recommender/models/episode.dart';

class SpotifyEpisodesParser {
  List<Episode> parse(String jsonData) {
    final decoded = jsonDecode(jsonData);
    List<Episode> episodes = [];

    for (var episodeItem in decoded['episodes']['items']) {
      String name = episodeItem['name'];
      String href = episodeItem['external_urls']['spotify'];
      String description = episodeItem['description'];
      episodes.add(Episode(name, href, description));
    }

    return episodes;
  }
}
