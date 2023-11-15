import 'package:flutter/material.dart';
import 'package:media_recommender/Widgets/tracks_list_widget.dart';
import 'package:media_recommender/models/spotify_search_results.dart';
import 'package:media_recommender/services/spotify_authorization.dart';
import 'package:media_recommender/services/spotify_query_parser.dart';
import 'package:media_recommender/services/spotify_search_service.dart';
import 'package:media_recommender/models/track.dart';
import 'package:media_recommender/Widgets/custom_checkbox_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Track Finder',
      theme: ThemeData(
        primarySwatch: Colors.green,
        // brightness: Brightness.dark, *use for a dark mode consider an option later
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Colors.white70),
          ),
        ),
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: Colors.greenAccent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.greenAccent),
        ),
      ),
      home: const MyHomePage(title: 'Media Recommender'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Track> tracksList = [];
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

  Future<void> handleButtonPress() async {
    setState(() {
      loadingStatus = true;
      tracksList = [];
    });

    try {
      final result = await fetchTracks(trackController.text);
      setState(() {
        tracksList = result.tracks!.take(10).toList();
        loadingStatus = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        loadingStatus = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  Future<SpotifySearchResults> fetchTracks(String searchTerm) async {
    final accessToken = await authorization.getSpotifyAccessToken();
    if (accessToken == null) {
      throw Exception('Failed to get the Spotify access token.');
    }

    final jsonResponse = await spotifyQuery.search(searchTerm, accessToken);
    return spotifyQueryParser.parseTracks(jsonResponse);
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
                  CustomCheckboxWidget(
                    title: 'Album',
                    value: albumValue,
                    onChanged: (bool newValue) {
                      setState(() => albumValue = newValue);
                    },
                  ),
                  CustomCheckboxWidget(
                    title: 'Artist',
                    value: artistValue,
                    onChanged: (bool newValue) {
                      setState(() => artistValue = newValue);
                    },
                  ),
                  CustomCheckboxWidget(
                    title: 'Audiobook',
                    value: audiobookValue,
                    onChanged: (bool newValue) {
                      setState(() => audiobookValue = newValue);
                    },
                  ),
                  CustomCheckboxWidget(
                    title: 'Episode',
                    value: episodeValue,
                    onChanged: (bool newValue) {
                      setState(() => episodeValue = newValue);
                    },
                  ),
                  CustomCheckboxWidget(
                    title: 'Playlist',
                    value: playlistValue,
                    onChanged: (bool newValue) {
                      setState(() => playlistValue = newValue);
                    },
                  ),
                  CustomCheckboxWidget(
                    title: 'Show',
                    value: showValue,
                    onChanged: (bool newValue) {
                      setState(() => showValue = newValue);
                    },
                  ),
                  CustomCheckboxWidget(
                    title: 'Track',
                    value: trackValue,
                    onChanged: (bool newValue) {
                      setState(() => trackValue = newValue);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              loadingStatus
                  ? const Center(child: CircularProgressIndicator())
                  : tracksList.isNotEmpty
                      ? TrackListWidget(tracks: tracksList)
                      : const Text(
                          'No tracks found. Please enter a search term and press Submit or Enter.',
                          textAlign: TextAlign.center,
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
