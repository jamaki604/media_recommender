import 'dart:convert';
import 'package:media_recommender/models/playlist.dart';

class SpotifyPlaylistsParser {
  List<Playlist> parsePlaylists(String jsonData) {
    final decoded = jsonDecode(jsonData);
    List<Playlist> playlists = [];

    for (var playlistItem in decoded['playlists']['items']) {
      String name = playlistItem['name'];
      String href = playlistItem['external_urls']['spotify'];
      String description = playlistItem['description'];
      playlists.add(Playlist(name, href, description));
    }

    return playlists;
  }
}
