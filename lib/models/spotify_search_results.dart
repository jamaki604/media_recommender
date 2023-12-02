import 'package:media_recommender/models/album.dart';
import 'package:media_recommender/models/artist.dart';
import 'package:media_recommender/models/audiobook.dart';
import 'package:media_recommender/models/episode.dart';
import 'package:media_recommender/models/playlist.dart';
import 'package:media_recommender/models/show.dart';
import 'package:media_recommender/models/track.dart';

class SpotifySearchResults {
  List<Track>? _tracks;
  List<Album>? _albums;
  List<Artist>? _artists;
  List<Audiobook>? _audiobooks;
  List<Episode>? _episodes;
  List<Playlist>? _playlists;
  List<Show>? _shows;

  SpotifySearchResults(
      List<Track>? tracks,
      List<Album>? albums,
      List<Artist>? artists,
      List<Audiobook>? audiobooks,
      List<Episode>? episodes,
      List<Playlist>? playlists,
      List<Show>? shows) {
    _tracks = tracks;
    _albums = albums;
    _artists = artists;
    _audiobooks = audiobooks;
    _episodes = episodes;
    _playlists = playlists;
    _shows = shows;
  }

  List<Track>? get tracks => _tracks;

  List<Show>? get show => _shows;

  List<Playlist>? get playlist => _playlists;

  List<Episode>? get episode => _episodes;

  List<Audiobook>? get audiobook => _audiobooks;

  List<Artist>? get artist => _artists;

  List<Album>? get album => _albums;
}
