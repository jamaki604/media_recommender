import 'package:flutter_test/flutter_test.dart';
import 'package:media_recommender/spotify_authorization.dart';
import 'package:media_recommender/token_storage.dart';

void main() {
  final auth = SpotifyAuthorization();
  final storage = TokenStorage();

  test('Obtain and store Spotify access token', () async {
    final accessToken = await auth.getSpotifyAccessToken();
    expect(accessToken, isNotNull, reason: 'Failed to get the Spotify access token.');

    await storage.storeToken(accessToken!);

    final retrievedToken = await storage.retrieveToken();
    expect(retrievedToken, isNotNull, reason: 'Failed to retrieve the token from storage.');
  });
}
