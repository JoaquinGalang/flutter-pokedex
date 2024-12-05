import 'package:flutter/material.dart';
import 'package:flutter_pokedex/utils/constants.dart';
import 'package:flutter_pokedex/utils/helper_functions.dart';

class PokemonTypeBox extends StatelessWidget {
  const PokemonTypeBox({
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
