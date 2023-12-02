import 'dart:convert';

import 'package:media_recommender/models/show.dart';

class SpotifyShowsParser {
  List<Show> parseShows(String jsonData) {
    final decoded = jsonDecode(jsonData);
    List<Show> shows = [];

    for (var episodeItem in decoded['shows']['items']) {
      String name = episodeItem['name'];
      String href = episodeItem['external_urls']['spotify'];
      String description = episodeItem['description'];
      shows.add(Show(name, href, description));
    }

    return shows;
  }
}
