import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:media_recommender/spotify_query_parser.dart';

void main() {
  
  test('The first track can be read from the json', (){
    final file = File('test/pokemonTracks.json');
    final string = file.readAsStringSync();

    final parser = SpotifyQueryParser();
    final result = parser.parseJson(string);

    expect(result, 'Pokémon Theme');
  });
}
