import 'dart:convert';
import 'package:http/http.dart' as http;

class SpotifyAuthorization {
  Future<String?> getSpotifyAccessToken() async {
    const clientId = 'b2468d9921304ca7af7d74ade787a068';
    const clientSecret = '554bdfd2dd9442349c85aeb1f6ac810e';

    final authorization = 'Basic ${base64Encode(
        utf8.encode('$clientId:$clientSecret'))}';

    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization': authorization,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'client_credentials',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['access_token'] as String?;
    } else {
      return null;
    }
  }

}
