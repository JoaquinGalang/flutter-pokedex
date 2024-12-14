import 'package:flutter/material.dart';
import 'package:flutter_pokedex/utils/constants.dart';

class PokedexSearchBar extends StatelessWidget {
  const PokedexSearchBar({
    super.key,
    required this.controller,
    required this.onEditingComplete,
  });

  final TextEditingController controller;
  final void Function() onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kGrayColor200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          onEditingComplete: onEditingComplete,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, size: 28),
              prefixIconColor: kGrayColor600,
              contentPadding: EdgeInsets.only(top: 12, bottom: 10),
              hintText: 'Search for a Pokémon',
              hintStyle: TextStyle(
                color: kGrayColor500,
              )
          ),
        ),
      ),
    );
  }
}