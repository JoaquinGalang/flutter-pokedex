import 'package:flutter/material.dart';
import 'package:flutter_pokedex/utils/constants.dart';
import 'package:flutter_pokedex/services/pokeapi_service.dart';
import 'package:flutter_pokedex/widgets/pokedex_search_bar.dart';
import 'package:flutter_pokedex/widgets/pokedex_entry_card.dart';

// TODO: Implement lazy loading principles.
// TODO: Implement pokemon ability view
// TODO: Implement pokemon weakness view
// TODO: Fix flavor text bug (sometimes its in a different language)


class PokedexMenuScreen extends StatefulWidget {
  PokedexMenuScreen({super.key});

  @override
  State<PokedexMenuScreen> createState() => _PokedexMenuScreenState();
}

class _PokedexMenuScreenState extends State<PokedexMenuScreen> {
  final PokeApiService _pokeApiService = PokeApiService();
  final TextEditingController _searchBarController = TextEditingController();
  List<Widget> pokedexEntries = [];

  void loadPokedexEntries(String search) async {

    // Clear current pokedexEntries
    setState(() {
      pokedexEntries = [];
    });

    // Initialize search result list and a list of all matches
    // When the search bar is an empty list, it loads all pokemon chronologically
    List<Widget> searchResults = [];
    List matchList =
        await _pokeApiService.searchForPokemon(search);

    // Create a new pokedex entry card for each match and add it to the match list
    for (int i = 0; i < matchList.length; i++) {
      Widget currentEntry = PokedexEntryCard(name: matchList[i]);
      searchResults.add(currentEntry);
    }

    // Assign the search results to the new pokedex entries
    setState(() {
      pokedexEntries = searchResults;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPokedexEntries(_searchBarController.text);
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
                onChanged: loadPokedexEntries,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
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
