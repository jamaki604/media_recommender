import 'package:flutter/material.dart';
import 'package:media_recommender/Widgets/album_list_widget.dart';
import 'package:media_recommender/Widgets/artist_list_widget.dart';
import 'package:media_recommender/Widgets/audiobook_list_widget.dart';
import 'package:media_recommender/Widgets/custom_checkbox_widget.dart';
import 'package:media_recommender/Widgets/episode_list_widget.dart';
import 'package:media_recommender/Widgets/playlist_list_widget.dart';
import 'package:media_recommender/Widgets/show_list_widget.dart';
import 'package:media_recommender/Widgets/tracks_list_widget.dart';
import 'package:media_recommender/models/album.dart';
import 'package:media_recommender/models/artist.dart';
import 'package:media_recommender/models/audiobook.dart';
import 'package:media_recommender/models/episode.dart';
import 'package:media_recommender/models/playlist.dart';
import 'package:media_recommender/models/show.dart';
import 'package:media_recommender/models/spotify_search_results.dart';
import 'package:media_recommender/models/track.dart';
import 'package:media_recommender/services/spotify_query_parser.dart';
import 'package:media_recommender/services/spotify_search_service.dart';
import '../services/spotify_authorization.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Track> tracksList = [];
  List<Album> albumList = [];
  List<Artist> artistList = [];
  List<Audiobook> audiobookList = [];
  List<Episode> episodeList = [];
  List<Playlist> playlistList = [];
  List<Show> showList = [];

  final trackController = TextEditingController();
  final spotifyQueryParser = SpotifyQueryParser();
  final authorization = SpotifyAuthorization();
  final spotifyQuery = SpotifySearchService();
  bool loadingStatus = false;
  bool albumValue = false;
  bool artistValue = false;
  bool trackValue = false;
  bool audiobookValue = false;
  bool episodeValue = false;
  bool showValue = false;
  bool playlistValue = false;

  @override
  void initState() {
    super.initState();
    trackController.addListener(onSearchChanged);
  }

  @override
  void dispose() {
    trackController.removeListener(onSearchChanged);
    trackController.dispose();
    super.dispose();
  }

  void onSearchChanged() {
    if (trackController.text.isNotEmpty && !loadingStatus) {
      handleButtonPress();
    }
  }

  Widget createCheckbox(String title, bool value, Function(bool) onChanged) {
    return CustomCheckboxWidget(
      title: title,
      value: value,
      onChanged: onChanged,
    );
  }

  Future<void> handleButtonPress() async {
    setState(() {
      loadingStatus = true;
      tracksList.clear();
      albumList.clear();
      artistList.clear();
      audiobookList.clear();
      episodeList.clear();
      playlistList.clear();
      showList.clear();
    });

    try {
      var types = {
        'track': trackValue,
        'artist': artistValue,
        'album': albumValue,
        'audiobook': audiobookValue,
        'episode': episodeValue,
        'show': showValue,
        'playlist': playlistValue,
      };

      for (var entry in types.entries) {
        if (entry.value) {
          var results = await fetchItems(trackController.text, entry.key);
          setState(() => updateListWithType(entry.key, results));
        }
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    } finally {
      if (!mounted) return;
      setState(() => loadingStatus = false);
    }
  }

  void updateListWithType(String type, SpotifySearchResults results) {
    switch (type) {
      case 'track':
        tracksList.addAll(results.tracks!.take(10).toList());
        break;
      case 'artist':
        artistList.addAll(results.artist!.take(10).toList());
        break;
      case 'album':
        albumList.addAll(results.album!.take(10).toList());
        break;
      case 'audiobook':
        audiobookList.addAll(results.audiobook!.take(10).toList());
        break;
      case 'episode':
        episodeList.addAll(results.episode!.take(10).toList());
        break;
      case 'show':
        showList.addAll(results.show!.take(10).toList());
        break;
      case 'playlist':
        playlistList.addAll(results.playlist!.take(10).toList());
        break;
      // Add other types if necessary
      default:
        throw Exception('Invalid type: $type');
    }
  }

  String getSearchTypes() {
    List<String> types = [];

    if (albumValue) types.add('album');
    if (artistValue) types.add('artist');
    if (trackValue) types.add('track');
    if (audiobookValue) types.add('audiobook');
    if (episodeValue) types.add('episode');
    if (showValue) types.add('show');
    if (playlistValue) types.add('playlist');

    return types.join('%2C');
  }

  Future<SpotifySearchResults> fetchItems(
      String searchTerm, String type) async {
    final accessToken = await authorization.getSpotifyAccessToken();
    if (accessToken == null) {
      throw Exception('Failed to get the Spotify access token.');
    }
    final jsonResponse =
        await spotifyQuery.search(searchTerm, type, accessToken);

    switch (type) {
      case 'track':
        return spotifyQueryParser.parseTracks(jsonResponse);
      case 'artist':
        return spotifyQueryParser.parseArtists(jsonResponse);
      case 'album':
        return spotifyQueryParser.parseAlbums(jsonResponse);
      case 'audiobook':
        return spotifyQueryParser.parseAudiobooks(jsonResponse);
      case 'episode':
        return spotifyQueryParser.parseEpisodes(jsonResponse);
      case 'show':
        return spotifyQueryParser.parseShows(jsonResponse);
      case 'playlist':
        return spotifyQueryParser.parsePlaylists(jsonResponse);
      default:
        throw Exception('Invalid type: $type');
    }
  }

  bool areAllListsEmpty() {
    return tracksList.isEmpty &&
        albumList.isEmpty &&
        artistList.isEmpty &&
        audiobookList.isEmpty &&
        episodeList.isEmpty &&
        playlistList.isEmpty &&
        showList.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: trackController,
                decoration: InputDecoration(
                  labelText: 'Search for a track',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onFieldSubmitted: (value) => handleButtonPress(),
                textInputAction: TextInputAction.search,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0,
                runSpacing: 8.0,
                children: <Widget>[
                  createCheckbox('Album', albumValue,
                      (newValue) => setState(() => albumValue = newValue)),
                  createCheckbox('Artist', artistValue,
                      (newValue) => setState(() => artistValue = newValue)),
                  createCheckbox('Track', trackValue,
                      (newValue) => setState(() => trackValue = newValue)),
                  createCheckbox('Audiobook', audiobookValue,
                      (newValue) => setState(() => audiobookValue = newValue)),
                  createCheckbox('Episode', episodeValue,
                      (newValue) => setState(() => episodeValue = newValue)),
                  createCheckbox('Show', showValue,
                      (newValue) => setState(() => showValue = newValue)),
                  createCheckbox('Playlist', playlistValue,
                      (newValue) => setState(() => playlistValue = newValue)),
                ],
              ),
              const SizedBox(height: 20),
              loadingStatus
                  ? const Center(child: CircularProgressIndicator())
                  : areAllListsEmpty()
                      ? const Text(
                          'No content found. Please enter a search term and press Submit or Enter.',
                          textAlign: TextAlign.center,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (tracksList.isNotEmpty) ...[
                              const Text('Tracks',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              TrackListWidget(tracks: tracksList),
                            ],
                            if (albumList.isNotEmpty) ...[
                              const Text('Albums',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              AlbumListWidget(album: albumList),
                            ],
                            if (artistList.isNotEmpty) ...[
                              const Text('Artists',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              ArtistListWidget(artist: artistList),
                            ],
                            if (audiobookList.isNotEmpty) ...[
                              const Text('Audiobooks',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              AudiobookListWidget(audiobook: audiobookList),
                            ],
                            if (episodeList.isNotEmpty) ...[
                              const Text('Episodes',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              EpisodeListWidget(episode: episodeList),
                            ],
                            if (playlistList.isNotEmpty) ...[
                              const Text('Playlists',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              PlaylistListWidget(playlist: playlistList),
                            ],
                            if (showList.isNotEmpty) ...[
                              const Text('Shows',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              ShowListWidget(show: showList),
                            ],
                          ],
                        ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: loadingStatus ? null : handleButtonPress,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
