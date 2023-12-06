import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:test/test.dart';
import 'package:media_recommender/services/spotify_authentication/dotenv_loader.dart';
import 'package:media_recommender/services/spotify_authentication/header_builder.dart';
import 'package:media_recommender/services/spotify_authentication/spotify_authorization.dart';
import 'package:http/http.dart' as http;

void main() {
  group('SpotifyAuthorization Tests', () {
    test('DotEnvloader is loading clientID', () async {
      final DotEnvLoader envLoader = DotEnvLoader();
      await envLoader.loadEnv();
      final clientId = envLoader.clientId;
      expect(clientId, isNotNull);
    });

    test('HeaderBuilder is building a header', () {
      final DotEnvLoader envLoader = DotEnvLoader();
      final HeaderBuilder headBuilder = HeaderBuilder(envLoader);
      expect(headBuilder, isNotNull);
      Map<String, String> headers = headBuilder.buildHeaders();
      expect(headers[HttpHeaders.contentTypeHeader],
          equals('application/x-www-form-urlencoded'));
    });

    test('Should fail with invalid URL and an error will be logged', () async {
      final spotifyAuth = SpotifyAuthorization();
      const invalidUrl = 'https://invalid.spotify.url';

      final result = await spotifyAuth.getSpotifyAccessToken(invalidUrl);

      expect(result, isNull);
    });

    test('ErrorHandler should print error in debug mode', () async {
      String? debugPrintOutput;
      debugPrint = (String? message, {int? wrapWidth}) {
        debugPrintOutput = message;
      };

      final spotifyAuth = SpotifyAuthorization();
      const invalidUrl = 'https://invalid.spotify.url';

      await spotifyAuth.getSpotifyAccessToken(invalidUrl);

      expect(debugPrintOutput, contains('Error obtaining token'));
    });

    test('Handle non-200 response correctly', () async {
      final mockHttpClient = http.Client();
      mockHttpClient.get(Uri.parse('https://example.com')).then((response) {
        return http.Response('{"error": "failed"}', 404);
      });

      final spotifyAuth = SpotifyAuthorization(client: mockHttpClient);
      final result =
          await spotifyAuth.getSpotifyAccessToken('https://example.com');

      expect(result, isNull);
    });
  });
}
