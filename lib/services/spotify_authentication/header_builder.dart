import 'dart:convert';
import 'dart:io';
import 'package:media_recommender/services/spotify_authentication/dotenv_loader.dart';

class HeaderBuilder {
  final DotEnvLoader envLoader;

  HeaderBuilder(this.envLoader);

  Map<String, String> buildHeaders() {
    final String credentials = base64Encode(
        utf8.encode('${envLoader.clientId}:${envLoader.clientSecret}'));
    return {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
      HttpHeaders.authorizationHeader: 'Basic $credentials',
    };
  }
}
