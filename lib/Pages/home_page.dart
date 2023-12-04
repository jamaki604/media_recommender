import 'package:flutter/material.dart';
import 'package:media_recommender/Widgets/custom_checkbox_widget.dart';
import 'package:media_recommender/models/album.dart';
import 'package:media_recommender/models/artist.dart';
import 'package:media_recommender/models/audiobook.dart';
import 'package:media_recommender/models/episode.dart';
import 'package:media_recommender/models/playlist.dart';
import 'package:media_recommender/models/show.dart';
import 'package:media_recommender/models/spotify_search_results.dart';
import 'package:media_recommender/models/track.dart';
import 'package:media_recommender/services/parsers/spotify_query_parser.dart';
import 'package:media_recommender/services/spotify_authentication/spotify_authorization.dart';
import 'package:media_recommender/services/spotify_search_service.dart';
import '../widgets/unified_display_widget.dart';

enum ContentType { track, album, artist, audiobook, episode, playlist, show }

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

  Map<ContentType, bool> contentTypeValues = {};

  @override
  void initState() {
    super.initState();
    trackController.addListener(onSearchChanged);

    for (var type in ContentType.values) {
      contentTypeValues[type] = false;
    }
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
      String searchTypes = formatSearchTypes();
      var results = await fetchItems(trackController.text, searchTypes);
      setState(() {
        updateListsWithResults(results);
      });
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    } finally {
      setState(() => loadingStatus = false);
    }
  }

  void updateListsWithResults(SpotifySearchResults results) {
    if (results.tracks != null && results.tracks!.isNotEmpty) {
      tracksList.addAll(results.tracks!.take(10).toList());
    }
    if (results.album != null && results.album!.isNotEmpty) {
      albumList.addAll(results.album!.take(10).toList());
    }
    if (results.artist != null && results.artist!.isNotEmpty) {
      artistList.addAll(results.artist!.take(10).toList());
    }
    if (results.audiobook != null && results.audiobook!.isNotEmpty) {
      audiobookList.addAll(results.audiobook!.take(10).toList());
    }
    if (results.episode != null && results.episode!.isNotEmpty) {
      episodeList.addAll(results.episode!.take(10).toList());
    }
    if (results.show != null && results.show!.isNotEmpty) {
      showList.addAll(results.show!.take(10).toList());
    }
    if (results.playlist != null && results.playlist!.isNotEmpty) {
      playlistList.addAll(results.playlist!.take(10).toList());
    }
  }

  String formatSearchTypes() {
    List<String> types = [];

    contentTypeValues.forEach((type, value) {
      if (value) {
        String searchType = getSearchType(type);
        if (searchType.isNotEmpty) {
          types.add(searchType);
        }
      }
    });

    return types.join('%2C');
  }

  String getSearchType(ContentType type) {
    switch (type) {
      case ContentType.track:
        return "track";
      case ContentType.album:
        return "album";
      case ContentType.artist:
        return "artist";
      case ContentType.audiobook:
        return "audiobook";
      case ContentType.episode:
        return "episode";
      case ContentType.show:
        return "show";
      case ContentType.playlist:
        return "playlist";
      default:
        return "";
    }
  }

  Future<SpotifySearchResults> fetchItems(
      String searchTerm, String searchTypes) async {
    final accessToken = await authorization.getSpotifyAccessToken();
    if (accessToken == null) {
      throw Exception('Failed to get the Spotify access token.');
    }
    final jsonResponse =
        await spotifyQuery.search(searchTerm, searchTypes, accessToken);

    SpotifySearchResults results =
        SpotifyQueryParser().parseResults(jsonResponse);
    return results;
  }

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  List<Widget> createCheckboxes() {
    List<Widget> checkboxes = [];
    contentTypeValues.forEach((type, value) {
      String title = type.toString().split('.').last;
      title = capitalize(title);

      var checkbox = CustomCheckboxWidget(
        title: title,
        value: value,
        onChanged: (newValue) {
          setState(() {
            contentTypeValues[type] = newValue;
          });
        },
      );
      checkboxes.add(checkbox);
    });
    return checkboxes;
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
                children: createCheckboxes(),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: loadingStatus ? null : handleButtonPress,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Submit'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              loadingStatus
                  ? const Text(
                      'No content found. Please enter a search term and press Submit or Enter.',
                      textAlign: TextAlign.center,
                    )
                  : UnifiedDisplayWidget(
                      tracks: tracksList,
                      albums: albumList,
                      artists: artistList,
                      audiobooks: audiobookList,
                      episodes: episodeList,
                      playlists: playlistList,
                      shows: showList,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
