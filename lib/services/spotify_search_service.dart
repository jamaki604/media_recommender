import 'package:http/http.dart' as http;

class SpotifySearchService {
  Future<String> search(String searchTerm, String types, String token) async {
    final String searchTypes = types.isEmpty ? "track" : types;

    final Uri url = Uri.parse(
        'https://api.spotify.com/v1/search?q=$searchTerm&type=$searchTypes&market=US&limit=10');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
