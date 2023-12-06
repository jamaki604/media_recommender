import 'dart:io';
import 'package:media_recommender/models/spotify_search_results.dart';
import 'package:test/test.dart';
import 'package:media_recommender/services/parsers/spotify_query_parser.dart';

void main() {
  SpotifySearchResults setupTest(String jsonFile) {
    final file = File(jsonFile);
    final string = file.readAsStringSync();
    final parser = SpotifyQueryParser();
    return parser.parseResults(string);
  }

  test('A track list can be created from the json', () {
    final result = setupTest('test/json_files/pokemonTracks.json');

    expect(result.tracks![0].name, 'Pokémon Theme');
  });

  test('A artist list can be created from the json', () {
    final result = setupTest('test/json_files/pokemonArtists.json');

    expect(result.artist![0].name, 'Pokémon');
  });

  test('A album list can be created from the json', () {
    final result = setupTest('test/json_files/pokemonAlbums.json');

    expect(result.album![0].name,
        'Pokemon - 2.b.a. Master - Music From The Hit Tv Series');
  });

  test('A audiobook list can be created from the json', () {
    final result = setupTest('test/json_files/pokemonAudiobooks.json');

    expect(result.audiobook![0].name, '101 Amazing Facts About Pokémon');
  });

  test('A playlist list can be created from the json', () {
    final result = setupTest('test/json_files/pokemonPlaylists.json');

    expect(result.playlist![0].name, 'Official Pokémon Songs');
  });

  test('A episode list can be created from the json', () {
    final result = setupTest('test/json_files/pokemonEpisodes.json');

    expect(result.episode![0].name, 'Pokemon - Bedtime Story');
  });

  test('A show list can be created from the json', () {
    final result = setupTest('test/json_files/pokemonShows.json');

    expect(result.show![0].name, 'The Roaring Trainers');
  });

  test('A multiple list can be created from the json', () {
    final result = setupTest('test/json_files/allTypesSearch.json');

    expect(result.show![0].name, 'The Roaring Trainers');
    expect(result.playlist![0].name, 'Official Pokémon Songs');
    expect(result.episode![0].name, 'Pokemon - Bedtime Story');
    expect(result.audiobook![0].name, '101 Amazing Facts About Pokémon');
    expect(result.album![0].name,
        'Pokemon - 2.b.a. Master - Music From The Hit Tv Series');
    expect(result.artist![0].name, 'Pokémon');
    expect(result.tracks![0].name, 'Pokémon Theme');
  });
}
