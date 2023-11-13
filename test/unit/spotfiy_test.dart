import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_recommender/services/spotify_authorization.dart';
import 'package:media_recommender/services/spotify_query_parser.dart';
import 'package:media_recommender/services/spotify_search_service.dart';
import 'package:media_recommender/token_storage.dart';

void main() {
  final auth = SpotifyAuthorization();
  final storage = TokenStorage();
  final spotifyQuery = SpotifySearchService();

  test('Search Spotify for "pokemon"', () async {
    final accessToken = await auth.getSpotifyAccessToken();
    expect(accessToken, isNotNull,
        reason: 'Failed to get the Spotify access token.');

    await storage.storeToken(accessToken!);

    final retrievedToken = await storage.retrieveToken();
    expect(retrievedToken, isNotNull,
        reason: 'Failed to retrieve the token from storage.');

    final searchResponse =
        await spotifyQuery.search('pokemon', retrievedToken!);
    expect(searchResponse, isNotNull, reason: 'Failed to search on Spotify.');
    expect(searchResponse, isNot('Failed to load Webpage'),
        reason: 'Error response from Spotify.');

    final parseResult = SpotifyQueryParser().parseTracks(searchResponse);

    for (var index = 0; index < min(10, parseResult.tracks!.length); index++) {
      print(
          '${index + 1}. ${parseResult.tracks![index].name} - ${parseResult.tracks![index].href}');
    }
  });
}
