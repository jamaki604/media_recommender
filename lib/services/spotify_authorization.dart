import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SpotifyAuthorization {
  Future<String?> getSpotifyAccessToken() async {
    await dotenv.load();
    final clientId = dotenv.env['CLIENT_ID'];
    final clientSecret = dotenv.env['CLIENT_SECRET'];

    final String credentials =
        base64Encode(utf8.encode('$clientId:$clientSecret'));

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
      HttpHeaders.authorizationHeader: 'Basic $credentials',
    };

    final body = {
      'grant_type': 'client_credentials',
    };

    final Uri url = Uri.parse('https://accounts.spotify.com/api/token');

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['access_token'];
      } else {
        print('Failed to obtain token: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error obtaining token: $e');
      return null;
    }
  }
}
