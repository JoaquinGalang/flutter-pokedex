import 'package:flutter/material.dart';
import '';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

String formatPokemonID(int pokemonID) {
  String stringID = pokemonID.toString();
  int lengthOfID = stringID.length;
  String formattedID = '#' + '0' * (4 - lengthOfID) + stringID;
  return formattedID;
}