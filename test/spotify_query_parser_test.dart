import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:media_recommender/spotify_query_parser.dart';

void main() {

  test('A track list can be created from the json', (){
    final file = File('test/pokemonTracks.json');
    final string = file.readAsStringSync();

    final parser = SpotifyQueryParser();
    final result = parser.parseJson(string);

    result.tracks.asMap().forEach((index, track) {
      print('${index + 1}. ${track.name}');
    });

    expect(result.tracks[0].name, 'Pokémon Theme');
  });
}
