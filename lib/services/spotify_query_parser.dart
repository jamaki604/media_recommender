import 'dart:convert';
import 'package:media_recommender/models/album.dart';
import 'package:media_recommender/models/artist.dart';
import 'package:media_recommender/models/audiobook.dart';
import 'package:media_recommender/models/episode.dart';
import 'package:media_recommender/models/playlist.dart';
import 'package:media_recommender/models/show.dart';
import 'package:media_recommender/models/track.dart';
import 'package:media_recommender/models/spotify_search_results.dart';

class SpotifyQueryParser {
  SpotifySearchResults parseTracks(String jsonData) {
    final decoded = jsonDecode(jsonData);
    List<Track> tracks = [];

    if (decoded['tracks'] != null &&
        decoded['tracks']['items'] != null &&
        decoded['tracks']['items'].isNotEmpty) {
      for (var trackItem in decoded['tracks']['items']) {
        String name = trackItem['name'];
        String href = trackItem['external_urls']['spotify'];
        String artist = trackItem['artists'][0]['name'];
        tracks.add(Track(name, href, artist));
      }
    }

    return SpotifySearchResults.tracks(tracks);
  }

  SpotifySearchResults parseArtists(String jsonData) {
    final decoded = jsonDecode(jsonData);
    List<Artist> artists = [];

    if (decoded['artists'] != null &&
        decoded['artists']['items'] != null &&
        decoded['artists']['items'].isNotEmpty) {
      for (var artistItem in decoded['artists']['items']) {
        String name = artistItem['name'];
        String href = artistItem['external_urls']['spotify'];
        artists.add(Artist(name, href));
      }
    }

    return SpotifySearchResults.artists(artists);
  }

  SpotifySearchResults parseAlbums(String jsonData) {
    final decoded = jsonDecode(jsonData);
    List<Album> albums = [];

    if (decoded['albums'] != null &&
        decoded['albums']['items'] != null &&
        decoded['albums']['items'].isNotEmpty) {
      for (var albumItem in decoded['albums']['items']) {
        String name = albumItem['name'];
        String href = albumItem['external_urls']['spotify'];
        String artist = albumItem['artists'][0]['name'];
        albums.add(Album(name, href, artist));
      }
    }

    return SpotifySearchResults.albums(albums);
  }

  SpotifySearchResults parseAudiobooks(String jsonData) {
    final decoded = jsonDecode(jsonData);
    List<Audiobook> audiobooks = [];

    if (decoded['audiobooks'] != null &&
        decoded['audiobooks']['items'] != null &&
        decoded['audiobooks']['items'].isNotEmpty) {
      for (var albumItem in decoded['audiobooks']['items']) {
        String name = albumItem['name'];
        String href = albumItem['external_urls']['spotify'];
        String author = albumItem['authors'][0]['name'];
        String description = albumItem['description'];
        audiobooks.add(Audiobook(name, author, href, description));
      }
    }

    return SpotifySearchResults.audiobooks(audiobooks);
  }

  SpotifySearchResults parsePlaylists(String jsonData) {
    final decoded = jsonDecode(jsonData);
    List<Playlist> playlists = [];

    if (decoded['playlists'] != null &&
        decoded['playlists']['items'] != null &&
        decoded['playlists']['items'].isNotEmpty) {
      for (var playlistItem in decoded['playlists']['items']) {
        String name = playlistItem['name'];
        String href = playlistItem['external_urls']['spotify'];
        String description = playlistItem['description'];
        playlists.add(Playlist(name, href, description));
      }
    }

    return SpotifySearchResults.playlists(playlists);
  }

  SpotifySearchResults parseEpisodes(String jsonData) {
    final decoded = jsonDecode(jsonData);
    List<Episode> episodes = [];

    if (decoded['episodes'] != null &&
        decoded['episodes']['items'] != null &&
        decoded['episodes']['items'].isNotEmpty) {
      for (var episodeItem in decoded['episodes']['items']) {
        String name = episodeItem['name'];
        String href = episodeItem['external_urls']['spotify'];
        String description = episodeItem['description'];
        episodes.add(Episode(name, href, description));
      }
    }

    return SpotifySearchResults.episodes(episodes);
  }

  SpotifySearchResults parseShows(String jsonData) {
    final decoded = jsonDecode(jsonData);
    List<Show> shows = [];

    if (decoded['shows'] != null &&
        decoded['shows']['items'] != null &&
        decoded['shows']['items'].isNotEmpty) {
      for (var episodeItem in decoded['shows']['items']) {
        String name = episodeItem['name'];
        String href = episodeItem['external_urls']['spotify'];
        String description = episodeItem['description'];
        shows.add(Show(name, href, description));
      }
    }

    return SpotifySearchResults.shows(shows);
  }
}
