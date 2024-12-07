import 'package:flutter/material.dart';

// Stats
const int maxIV = 31;
const int maxEV = 252;
const double beneficialNatureMultiplier = 1.1;

// Grays
const kGrayColor600 = Color(0xFF545454);
const kGrayColor500 = Color(0xFFA6A6A6);
const kGrayColor400 = Color(0xFFBFBDBC);
const kGrayColor300 = Color(0xFFD9D9D9);
const kGrayColor200 = Color(0xFFE9E8E8);
const kGrayColor100 = Color(0xFFF8F8F8);

// Map Pokemon Type Colors
final Map<String, Color> brightColors = {
  'normal': const Color(0xFFAAA67F),
  'fire': const Color(0xFFF57D31),
  'water': const Color(0xFF6493EB),
  'electric': const Color(0xFFF9CF30),
  'grass': const Color(0xFF74CB48),
  'ice': const Color(0xFF9AD6DF),
  'fighting': const Color(0xFFC12239),
  'poison': const Color(0xFFA43E9E),
  'ground': const Color(0xFFDEC16B),
  'flying': const Color(0xFFA891EC),
  'psychic': const Color(0xFFFB5584),
  'bug': const Color(0xFFA7B723),
  'rock': const Color(0xFFB69E31),
  'ghost': const Color(0xFF70559B),
  'dragon': const Color(0xFF7037FF),
  'dark': const Color(0xFF75574C),
  'steel': const Color(0xFFB7B9D0),
  'fairy': const Color(0xFFE69EAC),
};

final Map<String, Color> darkColors = {
  'normal': const Color(0xFF6D5F48),
  'fire': const Color(0xFFB04123),
  'water': const Color(0xFF3A57A0),
  'electric': const Color(0xFFB89921),
  'grass': const Color(0xFF4E8A33),
  'ice': const Color(0xFF4C909B),
  'fighting': const Color(0xFF842029),
  'poison': const Color(0xFF6D276D),
  'ground': const Color(0xFFB2934A),
  'flying': const Color(0xFF7760A4),
  'psychic': const Color(0xFFB2415C),
  'bug': const Color(0xFF707F17),
  'rock': const Color(0xFF846B22),
  'ghost': const Color(0xFF4B3B6E),
  'dragon': const Color(0xFF4B27B3),
  'dark': const Color(0xFF4C3B2F),
  'steel': const Color(0xFF83859A),
  'fairy': const Color(0xFFB3687A),
};

// Text Styles
const TextStyle kTitleTextStyle = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w900,
);

// Text Styles
const TextStyle kHeaderTextStyle = TextStyle(
  fontSize: 26,
);

const TextStyle kGrayDefaultTextStyle = TextStyle(
  fontSize: 16,
  color: kGrayColor600,
);

const TextStyle kLightGrayDefaultTextStyle = TextStyle(
  fontSize: 16,
  color: kGrayColor500,
);

const TextStyle kAbilityTitleTextStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
);