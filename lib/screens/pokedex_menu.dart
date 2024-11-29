import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants.dart';

class PokedexMenu extends StatelessWidget {
  const PokedexMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pokédex',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Search for Pokémon by name or using the\nNational Pokédex number.',
                style: TextStyle(
                  fontSize: 16,
                  color: kGrayColor600,
                ),
              ),
              const SizedBox(height: 10),
              Container(
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
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: kGrayColor600,
                      contentPadding: EdgeInsets.only(top: 12, bottom: 10),
                      hintText: 'What Pokémon are you looking for?',
                      hintStyle: TextStyle(
                        color: kGrayColor500,
                      )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
