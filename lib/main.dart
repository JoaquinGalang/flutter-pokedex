import 'package:flutter/material.dart';
import 'package:flutter_pokedex/screens/pokedex_entry_screen.dart';
import 'package:flutter_pokedex/screens/pokedex_menu_screen.dart';
import 'package:flutter_pokedex/services/pokeapi_service.dart';

void main() async {
  PokeApiService pokeApiService = PokeApiService();
  var jsonData = await pokeApiService.getPokemonData(id: 1);
  runApp(
    const MaterialApp(
      home: PokedexMenuScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}