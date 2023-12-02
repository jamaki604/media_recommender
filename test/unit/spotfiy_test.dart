import 'package:flutter_test/flutter_test.dart';
import 'package:media_recommender/services/spotify_authentication/spotify_authorization.dart';
import 'package:media_recommender/services/spotify_search_service.dart';

void main() {
  final SpotifyAuthorization auth = SpotifyAuthorization();
  final SpotifySearchService spotifyQuery = SpotifySearchService();

  test('Search Spotify for "pokemon"', () async {
    final accessToken = await auth.getSpotifyAccessToken();
    expect(accessToken, isNotNull,
        reason: 'Failed to get the Spotify access token.');

    if (accessToken != null) {
      final searchResponse =
          await spotifyQuery.search('pokemon', "track", accessToken);
      expect(searchResponse, isNotNull, reason: 'Failed to search on Spotify.');
      expect(searchResponse, isNot('Failed to load Webpage'),
          reason: 'Error response from Spotify.');
    }
  });
}
