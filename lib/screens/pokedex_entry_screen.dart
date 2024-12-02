import 'package:flutter/material.dart';
import 'package:flutter_pokedex/services/constants.dart';
import 'package:flutter_pokedex/widgets/pokedex_entry_card.dart';

class PokedexEntryScreen extends StatelessWidget {
  const PokedexEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 12,
              color: darkColors['water'],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/9.png'),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('#007', style: kGrayDefaultTextStyle),
                              Text('Blastoise', style: kTitleTextStyle),
                              PokemonTypeCard(type: 'water')
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Blastoise has water spouts that protrude from its shell. The water spouts are very accurate. They can shoot bullets of water with enough accuracy to strike empty cans from a distance of over 160 feet.',
                      style: kDescriptionTextStyle,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        PhysicalQuantityCard(
                          quantity: "5'03\"",
                          type: 'HEIGHT',
                        ),
                        PhysicalQuantityCard(
                          quantity: "188.5 lbs",
                          type: 'WEIGHT',
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text('Statistics', style: kHeaderTextStyle)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhysicalQuantityCard extends StatelessWidget {
  const PhysicalQuantityCard({
    super.key,
    required this.quantity,
    required this.type,
  });

  final String quantity;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 85,
          decoration: BoxDecoration(
            color: kGrayColor200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                quantity,
                style: TextStyle(
                  color: kGrayColor600,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                type,
                style: TextStyle(
                  color: kGrayColor500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
