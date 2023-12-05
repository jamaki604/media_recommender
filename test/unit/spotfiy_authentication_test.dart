import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_recommender/services/spotify_authentication/dotenv_loader.dart';
import 'package:media_recommender/services/spotify_authentication/header_builder.dart';
import 'package:media_recommender/services/spotify_authentication/spotify_authorization.dart';

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
      // Capture the output of debugPrint
      String? debugPrintOutput;
      debugPrint = (String? message, {int? wrapWidth}) {
        debugPrintOutput = message;
      };

      final spotifyAuth = SpotifyAuthorization();
      const invalidUrl = 'https://invalid.spotify.url';

      await spotifyAuth.getSpotifyAccessToken(invalidUrl);

      // Check if debugPrint was called with an error message
      expect(debugPrintOutput, contains('Error obtaining token'));
    });
  });
}
