import 'dart:convert';
import 'package:media_recommender/services/spotify_authentication/dotenv_loader.dart';
import 'package:media_recommender/services/spotify_authentication/error_handler.dart';
import 'package:media_recommender/services/spotify_authentication/header_builder.dart';
import 'package:http/http.dart' as http;

class SpotifyAuthorization {
  final DotEnvLoader envLoader = DotEnvLoader();
  final ErrorHandler errorHandler = ErrorHandler();

  Future<String?> getSpotifyAccessToken() async {
    await envLoader.loadEnv();
    final headerBuilder = HeaderBuilder(envLoader);
    final headers = headerBuilder.buildHeaders();

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
        errorHandler.handleResponseError(response.statusCode);
        return null;
      }
    } catch (e) {
      errorHandler.handleExceptionError(e);
      return null;
    }
  }
}
