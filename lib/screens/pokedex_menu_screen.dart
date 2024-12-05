import 'package:flutter/material.dart';
import 'package:flutter_pokedex/utils/constants.dart';
import 'package:flutter_pokedex/widgets/pokedex_search_bar.dart';
import 'package:flutter_pokedex/widgets/pokedex_entry_card.dart';

// TODO: Implement lazy loading principles.
// TODO: Implement search feature.

class PokedexMenuScreen extends StatefulWidget {
  PokedexMenuScreen({super.key});

  @override
  State<PokedexMenuScreen> createState() => _PokedexMenuScreenState();
}

class _PokedexMenuScreenState extends State<PokedexMenuScreen> {
  List<Widget> pokedexEntries = [];

  void loadPokedexEntries() {
    for (int i = 1; i < 151; i++) {
      Widget currentEntry = PokedexEntryCard(pokemonID: i);
      pokedexEntries.add(currentEntry);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
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
              const PokedexSearchBar(),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: pokedexEntries,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
