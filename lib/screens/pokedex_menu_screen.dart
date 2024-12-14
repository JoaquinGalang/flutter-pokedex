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
  bool _isLoading = true;
  int maxEntries = 15;

  List<Widget> pokedexEntries = [];

  void loadPokedexEntries() async {
    // Clear current pokedexEntries
    setState(() {
      _isLoading = true;
      maxEntries += 15;
      pokedexEntries = pokedexEntries;
    });

    // Initialize search result list and a list of all matches
    // When the search bar is an empty list, it loads all pokemon chronologically
    List<Widget> searchResults = [];
    List matchList =
        await _pokeApiService.searchForPokemon(_searchBarController.text);

    int numberOfEntries =
        (matchList.length < maxEntries) ? matchList.length : maxEntries;

    // Create a new pokedex entry card for each match and add it to the match list
    for (int i = 0; i < numberOfEntries; i++) {
      Map<String, dynamic> pokemonData =
          await _pokeApiService.getPokemonData(matchList[i]);
      Widget currentEntry = PokedexEntryCard(data: pokemonData);
      searchResults.add(currentEntry);
    }

    Widget loadMoreButton = LoadMoreButton(isLoading: !_isLoading, onPressed: loadMorePokedexEntries);

    if (matchList.length > 15) {
      searchResults.add(loadMoreButton);
    }

    // Assign the search results to the new pokedex entries
    setState(() {
      _isLoading = false;
      pokedexEntries = searchResults;
    });
  }

  void loadMorePokedexEntries() {
    setState(() {
      maxEntries += 15;
      loadPokedexEntries();
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
