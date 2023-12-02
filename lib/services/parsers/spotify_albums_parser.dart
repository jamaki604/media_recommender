import 'dart:convert';
import 'package:media_recommender/models/album.dart';

class SpotifyAlbumsParser {
  List<Album> parseAlbums(String jsonData) {
    final decoded = jsonDecode(jsonData);
    List<Album> albums = [];

    for (var albumItem in decoded['albums']['items']) {
      String name = albumItem['name'];
      String href = albumItem['external_urls']['spotify'];
      String artist = albumItem['artists'][0]['name'];
      albums.add(Album(name, href, artist));
    }

    return albums;
  }
}
