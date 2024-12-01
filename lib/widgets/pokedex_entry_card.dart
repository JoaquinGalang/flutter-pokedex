import 'package:flutter/material.dart';
import 'package:flutter_pokedex/services/constants.dart';
import 'package:flutter_pokedex/services/helper_functions.dart';

class PokedexEntryCard extends StatelessWidget {
  const PokedexEntryCard({
    super.key,
    required this.pokemonID,
    required this.pokemonName,
    required this.pokemonTypes,
  });

  final int pokemonID;
  final String pokemonName;
  final List pokemonTypes;

  List<Widget> pokemonTypeCardBuilder() {
    List<Widget> typeCardList = [];
    for (var type in pokemonTypes) {
      typeCardList.add(PokemonTypeCard(type: type));
    }
    return typeCardList;
  }

  String formatPokemonID(int pokemonID) {
    String stringID = pokemonID.toString();
    int lengthOfID = stringID.length;
    String formattedID = '#' + '0'*(4-lengthOfID) + stringID;
    return formattedID;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: brightColors[pokemonTypes[0]],
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
                  Text(formatPokemonID(pokemonID)),
                  Text(
                    pokemonName,
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
                image: NetworkImage('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonID.png'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PokemonTypeCard extends StatelessWidget {
  const PokemonTypeCard({
    super.key,
    required this.type,
  });

  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Container(
        width: 60,
        height: 25,
        decoration: BoxDecoration(
          color: darkColors[type],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            type.capitalize(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}