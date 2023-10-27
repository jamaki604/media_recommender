import 'dart:convert';

class SpotifyQueryParser {

  parseJson(String jsonData){
    final decoded = jsonDecode(jsonData);
    if (decoded['tracks'] != null && decoded['tracks']['items'] != null && decoded['tracks']['items'].isNotEmpty) {
      final firstTrack = decoded['tracks']['items'][0];
      return firstTrack['name'];
    }

    return null; // or throw an error or return a default value
  }

}
