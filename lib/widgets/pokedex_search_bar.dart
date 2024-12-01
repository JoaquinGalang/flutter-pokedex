import 'package:flutter/material.dart';
import 'package:flutter_pokedex/services/constants.dart';

class PokedexSearchBar extends StatelessWidget {
  const PokedexSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kGrayColor200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, size: 28),
              prefixIconColor: kGrayColor600,
              contentPadding: EdgeInsets.only(top: 12, bottom: 10),
              hintText: 'What Pokémon are you looking for?',
              hintStyle: TextStyle(
                color: kGrayColor500,
              )
          ),
        ),
      ),
    );
  }
}