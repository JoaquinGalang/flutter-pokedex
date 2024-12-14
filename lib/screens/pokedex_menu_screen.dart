import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/utils/constants.dart';
import 'package:flutter_pokedex/services/pokeapi_service.dart';
import 'package:flutter_pokedex/widgets/pokeball_loading_indicator.dart';
import 'package:flutter_pokedex/widgets/pokedex_search_bar.dart';
import 'package:flutter_pokedex/widgets/pokedex_entry_card.dart';
import 'package:flutter_pokedex/widgets/load_more_button.dart';

// TODO: Implement lazy loading principles.
// TODO: Implement pokemon weakness view

class PokedexMenuScreen extends StatefulWidget {
  PokedexMenuScreen({super.key});

  @override
  State<PokedexMenuScreen> createState() => _PokedexMenuScreenState();
}

class _PokedexMenuScreenState extends State<PokedexMenuScreen> {
  final PokeApiService _pokeApiService = PokeApiService();
  final TextEditingController _searchBarController = TextEditingController();
  final ScrollController _pokedexEntryScrollController = ScrollController();
  bool _isLoading = true;
  int maxEntries = 15;
  int? numberOfEntries;

  List<Widget> pokedexEntries = [];
  List matchList = [];

  void loadPokedexEntries() async {
    setState(() {
      _isLoading = true;
      maxEntries = 15;
    });
    await findPokemonMatches();
    await buildPokedexEntries();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> findPokemonMatches() async {
    matchList =
        await _pokeApiService.searchForPokemon(_searchBarController.text);
  }

  Future<void> buildPokedexEntries() async {
    // Set loading to true

    // Initialize search result list and a list of all matches
    // When the search bar is an empty list, it loads all pokemon chronologically
    List<Widget> searchResults = [];

    // Get number of entries
    numberOfEntries =
        (matchList.length < maxEntries) ? matchList.length : maxEntries;

    // Create a new pokedex entry card for each match and add it to the match list
    for (int i = 0; i < numberOfEntries!; i++) {
      Map<String, dynamic> pokemonData =
          await _pokeApiService.getPokemonData(matchList[i]);
      Widget currentEntry = PokedexEntryCard(data: pokemonData);
      searchResults.add(currentEntry);
    }

    Widget loadMoreButton = LoadMoreButton(onPressed: loadMorePokedexEntries);

    if (numberOfEntries! < matchList.length) {
      searchResults.add(loadMoreButton);
    }

    // Assign the search results to the new pokedex entries
    setState(() {
      pokedexEntries = searchResults;
    });
  }

  Future<void> loadMorePokedexEntries() async {
    int previousMaxEntries = maxEntries;
    maxEntries = (matchList.length < maxEntries + 15)
        ? matchList.length
        : maxEntries + 15;
    List<Widget> newEntries = [];
    for (int i = previousMaxEntries; i < maxEntries; i++) {
      Map<String, dynamic> pokemonData =
          await _pokeApiService.getPokemonData(matchList[i]);
      Widget currentEntry = PokedexEntryCard(data: pokemonData);
      newEntries.add(currentEntry);
    }

    Widget loadMoreButton = LoadMoreButton(onPressed: loadMorePokedexEntries);

    if (maxEntries < matchList.length) {
      newEntries.add(loadMoreButton);
    }

    pokedexEntries.removeLast();

    setState(() {
      pokedexEntries = pokedexEntries + newEntries;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPokedexEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Pokédex',
                style: kTitleTextStyle,
              ),
              const SizedBox(height: 10),
              const Text(
                'Search for Pokémon by name or using the\nNational Pokédex number.',
                style: kGrayDefaultTextStyle,
              ),
              const SizedBox(height: 10),
              PokedexSearchBar(
                controller: _searchBarController,
                onEditingComplete: loadPokedexEntries,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: (_isLoading)
                    ? const PokeballLoadingIndicator()
                    : ListView(
                        controller: _pokedexEntryScrollController,
                        children: pokedexEntries,
                      ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
