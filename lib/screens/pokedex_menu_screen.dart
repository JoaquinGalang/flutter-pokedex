import 'package:flutter/material.dart';
import 'package:flutter_pokedex/services/constants.dart';
import 'package:flutter_pokedex/widgets/pokedex_search_bar.dart';
import 'package:flutter_pokedex/widgets/pokedex_entry_card.dart';

// TODO: FIX THE CARD COLOR THINGY!!!!

class PokedexMenuScreen extends StatelessWidget {
  const PokedexMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: ListView(
            children: const [
              SizedBox(height: 20),
              Text(
                'Pokédex',
                style: kTitleTextStyle,
              ),
              SizedBox(height: 10),
              Text(
                'Search for Pokémon by name or using the\nNational Pokédex number.',
                style: kGrayDefaultTextStyle,
              ),
              SizedBox(height: 10),
              PokedexSearchBar(),
              SizedBox(height: 30),
              PokedexEntryCard(
                pokemonID: 1,
                pokemonName: 'Bulbasaur',
                pokemonTypes: ['grass', 'poison'],
              ),
              PokedexEntryCard(
                pokemonID: 2,
                pokemonName: 'Ivysaur',
                pokemonTypes: ['grass', 'poison'],
              ),
              PokedexEntryCard(
                pokemonID: 3,
                pokemonName: 'Venusaur',
                pokemonTypes: ['grass', 'poison'],
              ),
              PokedexEntryCard(
                pokemonID: 4,
                pokemonName: 'Charmander',
                pokemonTypes: ['fire'],
              ),
              PokedexEntryCard(
                pokemonID: 5,
                pokemonName: 'Charmeleon',
                pokemonTypes: ['fire'],
              ),
              PokedexEntryCard(
                pokemonID: 6,
                pokemonName: 'Charizard',
                pokemonTypes: ['fire', 'flying'],
              ),
              PokedexEntryCard(
                pokemonID: 7,
                pokemonName: 'Squirtle',
                pokemonTypes: ['water'],
              ),
              PokedexEntryCard(
                pokemonID: 8,
                pokemonName: 'Wartortle',
                pokemonTypes: ['water'],
              ),
              PokedexEntryCard(
                pokemonID: 9,
                pokemonName: 'Blastoise',
                pokemonTypes: ['water'],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
