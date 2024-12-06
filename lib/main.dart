import 'package:flutter/material.dart';
import 'package:flutter_pokedex/screens/pokedex_menu_screen.dart';
import 'package:flutter_pokedex/services/pokeapi_service.dart';

void main() async {
  PokeApiService pokeApiService = PokeApiService();
  runApp(
    MaterialApp(
      home: PokedexMenuScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}