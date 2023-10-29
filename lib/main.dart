import 'package:flutter/material.dart';
import 'package:media_recommender/parse_results.dart';
import 'package:media_recommender/spotify_authorization.dart';
import 'package:media_recommender/spotify_query_parser.dart';
import 'package:media_recommender/spotify_query_updater.dart';
import 'package:media_recommender/track.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Spotify Track Finder'),
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
  final auth = SpotifyAuthorization();
  final spotifyQuery = SpotifyQueryUpdater();
  bool isLoading = false;

  Future<void> handleButtonPress() async {
    setState(() {
      isLoading = true;
      tracksList = [];
    });

    try {
      final result = await fetchTracks(trackController.text);
      setState(() {
        tracksList = result.tracks.take(10).toList();  // Limiting the number of tracks to 10.
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  Future<ParseResult> fetchTracks(String searchTerm) async {
    final accessToken = await auth.getSpotifyAccessToken();
    if (accessToken == null) {
      throw Exception('Failed to get the Spotify access token.');
    }

    final jsonResponse = await spotifyQuery.search(searchTerm, accessToken);
    return spotifyQueryParser.parseJson(jsonResponse);
  }

  Widget buildTrackList(List<Track> tracks) {
    return Column(
      children: tracks.asMap().entries.map((entry) => buildTrack(entry.key, entry.value)).toList(),
    );
  }

  Widget buildTrack(int index, Track track) {
    return InkWell(
      onTap: () async {
        if (await canLaunchUrlString(track.href)) {
          await launchUrlString(track.href);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not launch URL')),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          "${index + 1}. ${track.name}",  // Displaying the track number.
          style: const TextStyle(fontSize: 24, color: Colors.blue, decoration: TextDecoration.underline),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                color: Colors.green,
                child: const Text(
                  'Enter the search term for a Spotify track list',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 345,
                child: TextField(
                  controller: trackController,
                  keyboardType: TextInputType.text,
                  enabled: !isLoading,
                  onSubmitted: (value) => handleButtonPress(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Search term goes here",
                  ),
                  style: Theme.of(context).textTheme.titleLarge, // Assuming titleLarge is defined in your theme.
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : handleButtonPress,
                child: const Text('Submit'),
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : tracksList.isEmpty
                  ? const Padding(
                padding: EdgeInsets.all(10),
                child: Text('No search results.', style: TextStyle(fontSize: 24)),
              )
                  : Container(
                padding: const EdgeInsets.all(10),
                child: buildTrackList(tracksList),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
