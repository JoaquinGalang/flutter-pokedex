import 'dart:convert';

import 'package:http/http.dart' as http;

class PokeApiService {
  final String urlPrefix = 'https://pokeapi.co/api/v2';
  final int lastPokedexID = 1024;

  Future<List> searchForPokemon(String search) async {

    // Fetch all pokemon data
    var url = Uri.parse('$urlPrefix/pokemon?limit=$lastPokedexID');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    List pokemonList = jsonData['results'];

    // Compare each pokemon name to the user's search and add matches to a list
    List pokemonMatches = [];
    for (int i = 0; i < pokemonList.length; i++) {
      String currentPokemon = pokemonList[i]['name'];
      if (currentPokemon.contains(search)) {
        pokemonMatches.add(currentPokemon);
      }
    }

    // Return match list
    return pokemonMatches;
  }

  Future<Map<String, dynamic>> getPokemonData(dynamic searchField) async {
    print('$urlPrefix/pokemon/$searchField');
    var url = Uri.parse('$urlPrefix/pokemon/$searchField');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    return jsonData;
  }

  Future<String> getFlavorText({required int id}) async {

    // Fetch pokemon species data from PokeAPI
    var url = Uri.parse('$urlPrefix/pokemon-species/$id');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    // Iterate through flavor text entries and return the first english flavor text description
    List flavorTextEntries = jsonData['flavor_text_entries'];
    String? flavorText;
    for (int i = 0; i < flavorTextEntries.length; i++) {
      if (flavorTextEntries[i]['language']['name'] == 'en') {
        flavorText = flavorTextEntries[i]['flavor_text'];
      }
    }
    return flavorText!;
  }

  Future<String> getAbilityEffect(String ability) async {

    // Fetch ability data from PokeAPI
    var url = Uri.parse('$urlPrefix/ability/$ability');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    // Iterate through effect entries and return the first english effect description
    List effectEntries = jsonData['effect_entries'];
    String? effect;
    for (int i = 0; i < effectEntries.length; i++) {
      if (effectEntries[i]['language']['name'] == 'en') {
        effect = effectEntries[i]['effect'];
        break;
      }
    }
    return effect!;
  }

  Future<Map<String, dynamic>> getTypeData(String type) async {
    var url = Uri.parse('$urlPrefix/type/$type');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    Map<String, dynamic> typeData = jsonData['damage_relations'];
    return typeData;
  }

}