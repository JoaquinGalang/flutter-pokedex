import 'package:flutter/material.dart';
import 'constants.dart';

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

double calculateMaxHP(double baseStat) {
  double maxHP = ((baseStat * 2 + maxIV + (maxEV ~/ 4)) + 110);
  return maxHP;
}

double calculateMaxStat({required double baseStat}) {
  double maxStat = ((baseStat * 2 + maxIV + (maxEV ~/ 4)) * beneficialNatureMultiplier + 5);
  return maxStat;
}