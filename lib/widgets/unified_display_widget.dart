import 'package:flutter/material.dart';
import 'package:media_recommender/Widgets/album_list_widget.dart';
import 'package:media_recommender/Widgets/artist_list_widget.dart';
import 'package:media_recommender/Widgets/audiobook_list_widget.dart';
import 'package:media_recommender/Widgets/episode_list_widget.dart';
import 'package:media_recommender/Widgets/playlist_list_widget.dart';
import 'package:media_recommender/Widgets/show_list_widget.dart';
import 'package:media_recommender/Widgets/tracks_list_widget.dart';
import 'package:media_recommender/models/track.dart';
import 'package:media_recommender/models/album.dart';
import 'package:media_recommender/models/artist.dart';
import 'package:media_recommender/models/audiobook.dart';
import 'package:media_recommender/models/episode.dart';
import 'package:media_recommender/models/playlist.dart';
import 'package:media_recommender/models/show.dart';

class UnifiedDisplayWidget extends StatelessWidget {
  final List<Track> tracks;
  final List<Album> albums;
  final List<Artist> artists;
  final List<Audiobook> audiobooks;
  final List<Episode> episodes;
  final List<Playlist> playlists;
  final List<Show> shows;

  const UnifiedDisplayWidget({
    super.key,
    required this.tracks,
    required this.albums,
    required this.artists,
    required this.audiobooks,
    required this.episodes,
    required this.playlists,
    required this.shows,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (tracks.isNotEmpty) ...[
          const Text('Tracks',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          TrackListWidget(tracks: tracks),
        ],
        if (albums.isNotEmpty) ...[
          const Text('Albums',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          AlbumListWidget(album: albums),
        ],
        if (artists.isNotEmpty) ...[
          const Text('Artists',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ArtistListWidget(artist: artists),
        ],
        if (audiobooks.isNotEmpty) ...[
          const Text('Audiobooks',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          AudiobookListWidget(audiobook: audiobooks),
        ],
        if (episodes.isNotEmpty) ...[
          const Text('Episodes',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          EpisodeListWidget(episode: episodes),
        ],
        if (playlists.isNotEmpty) ...[
          const Text('Playlists',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          PlaylistListWidget(playlist: playlists),
        ],
        if (shows.isNotEmpty) ...[
          const Text('Shows',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ShowListWidget(show: shows),
        ],
      ],
    );
  }
}
