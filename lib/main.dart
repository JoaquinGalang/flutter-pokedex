import 'package:flutter/material.dart';
import 'package:flutter_pokedex/screens/pokedex_entry_screen.dart';
import 'package:flutter_pokedex/screens/pokedex_menu_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      home: PokedexEntryScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}