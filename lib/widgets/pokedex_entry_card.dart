import 'package:flutter/material.dart';
import 'package:flutter_pokedex/screens/pokedex_entry_screen.dart';
import 'package:flutter_pokedex/utils/constants.dart';
import 'package:flutter_pokedex/services/pokeapi_service.dart';
import 'package:flutter_pokedex/utils/helper_functions.dart';
import 'package:flutter_pokedex/widgets/pokemon_type_box.dart';

class PokedexEntryCard extends StatefulWidget {
  const PokedexEntryCard({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  State<PokedexEntryCard> createState() => _PokedexEntryCardState();
}

class _PokedexEntryCardState extends State<PokedexEntryCard> {
  Map<String, dynamic>? pokemonData;
  int? pokemonID;
  String? pokemonName;
  List? pokemonTypes;

  List<Widget> pokemonTypeCardBuilder() {
    List<Widget> typeCardList = [];
    for (var type in pokemonTypes!) {
      typeCardList.add(PokemonTypeBox(type: type));
    }
    return typeCardList;
  }

  List<String> getPokemonTypes(List types) {
    List<String> typeList = [];
    for (int i = 0; i < types.length; i++) {
      String type = types[i]['type']['name'];
      typeList.add(type);
    }
    return typeList;
  }

  void loadPokemonData() {
    pokemonData = widget.data;
    pokemonID = pokemonData!['id'];
    pokemonName = pokemonData!['name'];
    pokemonTypes = getPokemonTypes(pokemonData!['types']);
  }

  @override
  void initState() {
    super.initState();
    loadPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PokedexEntryScreen(
                pokemonData: pokemonData!,
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: brightColors[pokemonTypes![0]],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(formatPokemonID(pokemonID!)),
                    Text(
                      pokemonName!.capitalize(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: pokemonTypeCardBuilder(),
                    ),
                  ],
                ),
                Image(
                  image: NetworkImage(
                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemonData!['id']}.png'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
