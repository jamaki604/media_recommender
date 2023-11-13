import 'package:media_recommender/models/album.dart';
import 'package:media_recommender/models/artist.dart';
import 'package:media_recommender/models/audiobook.dart';
import 'package:media_recommender/models/episode.dart';
import 'package:media_recommender/models/playlist.dart';
import 'package:media_recommender/models/show.dart';
import 'package:media_recommender/models/track.dart';

class SpotifySearchResults {
  final List<Track>? _tracks;
  final List<Album>? _albums;
  final List<Artist>? _artists;
  final List<Audiobook>? _audiobooks;
  final List<Episode>? _episodes;
  final List<Playlist>? _playlists;
  final List<Show>? _shows;

  SpotifySearchResults.tracks(tracks)
      : _tracks = tracks,
        _albums = null,
        _artists = null,
        _audiobooks = null,
        _episodes = null,
        _playlists = null,
        _shows = null;

  SpotifySearchResults.albums(albums)
      : _albums = albums,
        _tracks = null,
        _artists = null,
        _audiobooks = null,
        _episodes = null,
        _playlists = null,
        _shows = null;

  SpotifySearchResults.artists(artists)
      : _artists = artists,
        _tracks = null,
        _albums = null,
        _audiobooks = null,
        _episodes = null,
        _playlists = null,
        _shows = null;

  SpotifySearchResults.audiobooks(audiobooks)
      : _audiobooks = audiobooks,
        _tracks = null,
        _albums = null,
        _artists = null,
        _episodes = null,
        _playlists = null,
        _shows = null;

  SpotifySearchResults.episodes(episodes)
      : _episodes = episodes,
        _tracks = null,
        _albums = null,
        _artists = null,
        _audiobooks = null,
        _playlists = null,
        _shows = null;

  SpotifySearchResults.playlists(playlists)
      : _playlists = playlists,
        _tracks = null,
        _albums = null,
        _artists = null,
        _audiobooks = null,
        _episodes = null,
        _shows = null;

  SpotifySearchResults.shows(shows)
      : _shows = shows,
        _tracks = null,
        _albums = null,
        _artists = null,
        _audiobooks = null,
        _episodes = null,
        _playlists = null;

  SpotifySearchResults(this._tracks, this._albums, this._artists,
      this._audiobooks, this._episodes, this._playlists, this._shows);

  List<Track>? get tracks => _tracks;

  List<Show>? get show => _shows;

  List<Playlist>? get playlist => _playlists;

  List<Episode>? get episode => _episodes;

  List<Audiobook>? get audiobook => _audiobooks;

  List<Artist>? get artist => _artists;

  List<Album>? get album => _albums;
}
