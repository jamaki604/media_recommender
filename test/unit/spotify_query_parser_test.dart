import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_recommender/services/parsers/spotify_query_parser.dart';

void main() {
  test('A track list can be created from the json', () {
    final file = File('test/json_files/pokemonTracks.json');
    final string = file.readAsStringSync();

    final parser = SpotifyQueryParser();
    final result = parser.parseResults(string);

    expect(result.tracks![0].name, 'Pokémon Theme');
  });

  test('A artist list can be created from the json', () {
    final file = File('test/json_files/pokemonArtists.json');
    final string = file.readAsStringSync();

    final parser = SpotifyQueryParser();
    final result = parser.parseResults(string);

    expect(result.artist![0].name, 'Pokémon');
  });

  test('A album list can be created from the json', () {
    final file = File('test/json_files/pokemonAlbums.json');
    final string = file.readAsStringSync();

    final parser = SpotifyQueryParser();
    final result = parser.parseResults(string);

    expect(result.album![0].name,
        'Pokemon - 2.b.a. Master - Music From The Hit Tv Series');
  });

  test('A audiobook list can be created from the json', () {
    final file = File('test/json_files/pokemonAudiobooks.json');
    final string = file.readAsStringSync();

    final parser = SpotifyQueryParser();
    final result = parser.parseResults(string);

    expect(result.audiobook![0].name, '101 Amazing Facts About Pokémon');
  });

  test('A playlist list can be created from the json', () {
    final file = File('test/json_files/pokemonPlaylists.json');
    final string = file.readAsStringSync();

    final parser = SpotifyQueryParser();
    final result = parser.parseResults(string);

    expect(result.playlist![0].name, 'Official Pokémon Songs');
  });

  test('A episode list can be created from the json', () {
    final file = File('test/json_files/pokemonEpisodes.json');
    final string = file.readAsStringSync();

    final parser = SpotifyQueryParser();
    final result = parser.parseResults(string);

    expect(result.episode![0].name, 'Pokemon - Bedtime Story');
  });

  test('A show list can be created from the json', () {
    final file = File('test/json_files/pokemonShows.json');
    final string = file.readAsStringSync();

    final parser = SpotifyQueryParser();
    final result = parser.parseResults(string);

    expect(result.show![0].name, 'The Roaring Trainers');
  });

  test('A multiple list can be created from the json', () {
    final file = File('test/json_files/allTypesSearch.json');
    final string = file.readAsStringSync();

    final parser = SpotifyQueryParser();
    final result = parser.parseResults(string);

    expect(result.show![0].name, 'The Roaring Trainers');
  });
}
