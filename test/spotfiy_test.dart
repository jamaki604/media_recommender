import 'package:flutter_test/flutter_test.dart';
import 'package:media_recommender/spotify_authorization.dart';

void main() {
  final auth = SpotifyAuthorization();

  test('Obtain Spotify access token', () async {
    final accessToken = await auth.getSpotifyAccessToken();
    expect(accessToken, isNotNull, reason: 'Failed to get the Spotify access token.');
  });
}
