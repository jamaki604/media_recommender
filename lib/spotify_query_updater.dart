import 'package:http/http.dart' as http;

class SpotifyQueryUpdater {
  Future<String> search(String searchTerm, String token) async {
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/search?q=$searchTerm&type=track&market=US'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return ('Failed to load Webpage');
    }
  }
}