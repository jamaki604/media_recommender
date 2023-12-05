import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnvLoader {
  String? clientId;
  String? clientSecret;
  String? spotifyURL;

  Future<void> loadEnv() async {
    await dotenv.load();
    clientId = dotenv.env['CLIENT_ID'];
    clientSecret = dotenv.env['CLIENT_SECRET'];
    spotifyURL = dotenv.env['SPOTIFY_URL'];
  }
}
