import 'dart:convert';

import 'package:http/http.dart' as http;

class PokeApiService {
  final String urlPrefix = 'https://pokeapi.co/api/v2';
  final int lastPokedexID = 1024;

  dynamic searchForPokemon(String search) async {

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

  dynamic getPokemonData(dynamic searchField) async {
    print('$urlPrefix/pokemon/$searchField');
    var url = Uri.parse('$urlPrefix/pokemon/$searchField');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    return jsonData;
  }

  dynamic getPokemonFlavorText({required int id}) async {
    var url = Uri.parse('$urlPrefix/pokemon-species/$id');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    return jsonData['flavor_text_entries'][0]['flavor_text'];
  }

  Future<String> getAbilityEffect(String ability) async {
    var url = Uri.parse('$urlPrefix/ability/$ability');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    String effect = jsonData['effect_entries'][0]['effect'];
    return effect;
  }

}