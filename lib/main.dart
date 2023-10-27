import 'package:flutter/material.dart';
import 'package:media_recommender/parse_results.dart';
import 'package:media_recommender/spotify_query_parser.dart';
import 'package:media_recommender/track.dart';


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
  String displayedText = '';
  final trackController = TextEditingController();
  final spotifyQueryParser = SpotifyQueryParser();
  bool isLoading = false;

  Future<void> handleButtonPress() async {
    setState(() {
      isLoading = true;
      displayedText = '';
    });

    try {
      final result = await fetchTracks();
      setState(() {
        if (result.tracks.isEmpty) {
          displayedText = "No tracks found.";
        } else {
          displayedText = formatTracks(result.tracks);
        }
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        displayedText = "An error occurred: $error";
        isLoading = false;
      });
    }
  }

  String formatTracks(List<Track> tracks) {
    final int length = tracks.length > 10 ? 10 : tracks.length;
    String result = '';
    for (int i = 0; i < length; i++) {
      result += "${i + 1}. ${tracks[i].name}\n";
    }
    return result;
  }

  Future<ParseResult> fetchTracks() async {
    // Here, you'd use the trackController.text to fetch JSON data from the Spotify API.
    // For now, I'll use a dummy json string to mimic that process.
    final dummyJsonData = '{"tracks": {"items": [{"name": "Track 1"}, {"name": "Track 2"}, ...]}}'; // ... represents the other dummy tracks.
    return spotifyQueryParser.parseJson(dummyJsonData);
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
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  displayedText,
                  style: const TextStyle(fontSize: 24),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
