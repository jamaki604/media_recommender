import 'dart:convert';
import 'package:media_recommender/models/audiobook.dart';
import 'package:media_recommender/models/playlist.dart';
import 'package:media_recommender/models/show.dart';
import 'package:media_recommender/models/spotify_search_results.dart';
import 'package:media_recommender/models/track.dart';
import 'package:media_recommender/services/parsers/spotify_albums_parser.dart';
import 'package:media_recommender/services/parsers/spotify_artists_parsers.dart';
import 'package:media_recommender/services/parsers/spotify_audiobooks_parser.dart';
import 'package:media_recommender/services/parsers/spotify_episodes_parser.dart';
import 'package:media_recommender/services/parsers/spotify_playlists_parser.dart';
import 'package:media_recommender/services/parsers/spotify_shows_parser.dart';
import 'package:media_recommender/services/parsers/spotify_tracks_parser.dart';

import '../../models/album.dart';
import '../../models/artist.dart';
import '../../models/episode.dart';

class SpotifyQueryParser {
  SpotifySearchResults parseResults(String jsonData) {
    final decoded = jsonDecode(jsonData);

    List<Track>? tracks;
    if (typeExists('tracks', decoded)) {
      tracks = SpotifyTracksParser().parseTracks(jsonData);
    }

    List<Album>? albums;
    if (typeExists('albums', decoded)) {
      albums = SpotifyAlbumsParser().parseAlbums(jsonData);
    }

    List<Artist>? artists;
    if (typeExists('artists', decoded)) {
      artists = SpotifyArtistsParser().parseArtists(jsonData);
    }

    List<Audiobook>? audiobooks;
    if (typeExists('audiobooks', decoded)) {
      audiobooks = SpotifyAudiobooksParser().parseAudiobooks(jsonData);
    }

    List<Episode>? episodes;
    if (typeExists('episodes', decoded)) {
      episodes = SpotifyEpisodesParser().parseEpisodes(jsonData);
    }

    List<Playlist>? playlists;
    if (typeExists('playlists', decoded)) {
      playlists = SpotifyPlaylistsParser().parsePlaylists(jsonData);
    }

    List<Show>? shows;
    if (typeExists('shows', decoded)) {
      shows = SpotifyShowsParser().parseShows(jsonData);
    }

    return SpotifySearchResults(
        tracks, albums, artists, audiobooks, episodes, playlists, shows);
  }

  bool typeExists(String type, dynamic decodedJson) {
    return decodedJson[type] != null &&
        decodedJson[type]['items'] != null &&
        decodedJson[type]['items'].isNotEmpty;
  }
}
