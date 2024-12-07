import 'package:flutter/material.dart';
import 'package:flutter_pokedex/utils/constants.dart';
import 'package:flutter_pokedex/utils/helper_functions.dart';
import 'package:flutter_pokedex/services/pokeapi_service.dart';
import 'package:flutter_pokedex/widgets/ability_bottom_sheet.dart';
import 'package:flutter_pokedex/widgets/pokemon_type_box.dart';
import 'package:flutter_pokedex/widgets/exit_button.dart';
import 'package:flutter_pokedex/widgets/physical_quantity_card.dart';
import 'package:flutter_pokedex/widgets/stat_linear_indicator.dart';
import 'package:flutter_pokedex/widgets/ability_link.dart';

// TODO: Add weaknesses

class PokedexEntryScreen extends StatefulWidget {
  const PokedexEntryScreen({super.key, required this.pokemonData});

  final Map pokemonData;

  @override
  State<PokedexEntryScreen> createState() => _PokedexEntryScreenState();
}

class _PokedexEntryScreenState extends State<PokedexEntryScreen> {
  final PokeApiService _pokeApiService = PokeApiService();

  Map<String, dynamic> pokemon = {
    'id': null,
    'name': null,
    'pokemonTypes': [],
    'image': null,
    'flavorText': null,
    'height': null,
    'weight': null,
    'abilities': null,
  };

  Map<String, double> pokemonStats = {
    'hitPoints': 0,
    'attack': 0,
    'defense': 0,
    'specialAtk': 0,
    'specialDef': 0,
    'speed': 0,
  };

  Map<String, double> pokemonMaxStats = {
    'hitPoints': 0,
    'attack': 0,
    'defense': 0,
    'specialAtk': 0,
    'specialDef': 0,
    'speed': 0,
  };

  Color? brightColor;
  Color? darkColor;
  bool _isLoading = true;

  Future<void> loadPokedexEntry() async {
    // Load pokemon essential pokemon details (e.g name, id, types, etc.)
    pokemon['id'] = formatPokemonID(widget.pokemonData['id']);
    String name = widget.pokemonData['name'];
    pokemon['name'] = name.capitalize();
    pokemon['pokemonTypes'] = getPokemonTypes(widget.pokemonData['types']);
    pokemon['primaryType'] = pokemon['pokemonTypes'][0];
    brightColor = brightColors[pokemon['primaryType']];
    darkColor = darkColors[pokemon['primaryType']];
    pokemon['image'] = widget.pokemonData['sprites']['front_default'];
    String flavorText = await _pokeApiService.getPokemonFlavorText(
        id: widget.pokemonData['id']);
    flavorText = flavorText.replaceAll('', ' ');
    pokemon['flavorText'] = flavorText.replaceAll('\n', ' ');

    // Load pokemon abilities
    pokemon['abilities'] = [];

    List abilityList = widget.pokemonData['abilities'];
    for (int i = 0; i < abilityList.length; i++) {
      String currentAbility = abilityList[i]['ability']['name'];
      String currentEffect = await _pokeApiService.getAbilityEffect(currentAbility);
      Map abilityData = {
        'ability': currentAbility,
        'effect': currentEffect,
      };
      pokemon['abilities'].add(abilityData);
    }

    // Load and format weight and height
    String height =
        '${(widget.pokemonData['height'] / 3.048).toStringAsFixed(2)}\"';
    pokemon['height'] = height.replaceAll('.', '\' ');
    pokemon['weight'] =
        '${(widget.pokemonData['weight'] / 4.536).toStringAsFixed(2)} lbs';

    // Load pokemon base base stats
    pokemonStats['hitPoints'] =
        widget.pokemonData['stats'][0]['base_stat'].toDouble();
    pokemonStats['attack'] =
        widget.pokemonData['stats'][1]['base_stat'].toDouble();
    pokemonStats['defense'] =
        widget.pokemonData['stats'][2]['base_stat'].toDouble();
    pokemonStats['specialAtk'] =
        widget.pokemonData['stats'][3]['base_stat'].toDouble();
    pokemonStats['specialDef'] =
        widget.pokemonData['stats'][4]['base_stat'].toDouble();
    pokemonStats['speed'] =
        widget.pokemonData['stats'][5]['base_stat'].toDouble();

    // Load pokemon max stats
    pokemonMaxStats['hitPoints'] = calculateMaxHP(pokemonStats['hitPoints']!);
    pokemonMaxStats['attack'] =
        calculateMaxStat(baseStat: pokemonStats['attack']!);
    pokemonMaxStats['defense'] =
        calculateMaxStat(baseStat: pokemonStats['defense']!);
    pokemonMaxStats['specialAtk'] =
        calculateMaxStat(baseStat: pokemonStats['specialAtk']!);
    pokemonMaxStats['specialDef'] =
        calculateMaxStat(baseStat: pokemonStats['specialDef']!);
    pokemonMaxStats['speed'] =
        calculateMaxStat(baseStat: pokemonStats['speed']!);

    setState(() {
      _isLoading = false;
    });
  }

  List<Widget> pokemonTypeCardBuilder(List<String> pokemonTypes) {
    List<Widget> typeCardList = [];
    for (var type in pokemonTypes) {
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

  List<Widget> pokemonAbilityBuilder() {
    List<Widget> abilityList = [];

    // Build a text widget for each listed ability
    for (int i = 0; i < pokemon['abilities'].length; i++) {
      String ability = formatPokemonAbility(pokemon['abilities'][i]['ability']);
      // String description = _pokeApiService.getAbilityEffect(ability);
      String description = pokemon['abilities'][i]['effect'];
      Widget abilityLink = AbilityLink(
        ability: ability,
        brightColor: brightColor,
        onTap: () {
          print(ability);
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return AbilityBottomSheet(
                ability: ability,
                description: description,
                color: darkColor!,
              );
            },
          );
        },
      );
      abilityList.add(abilityLink);
    }

    return abilityList;
  }

  @override
  void initState() {
    super.initState();
    loadPokedexEntry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 12,
              color: darkColor,
            ),
            Expanded(
              child: (_isLoading)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(
                        children: [
                          const SizedBox(height: 15),
                          Stack(
                            children: [
                              const Align(
                                alignment: Alignment.topRight,
                                child: ExitButton(),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: AspectRatio(
                                        aspectRatio: 1 / 1,
                                        child: Image(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            pokemon['image'],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(pokemon['id'],
                                            style: kGrayDefaultTextStyle),
                                        Text(pokemon['name'],
                                            style: kTitleTextStyle),
                                        Row(
                                          children: pokemonTypeCardBuilder(
                                              pokemon['pokemonTypes']),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            pokemon['flavorText'],
                            style: kLightGrayDefaultTextStyle,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              PhysicalQuantityCard(
                                quantity: pokemon['height'],
                                type: 'HEIGHT',
                              ),
                              PhysicalQuantityCard(
                                quantity: pokemon['weight'],
                                type: 'WEIGHT',
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Text('Base Stats', style: kHeaderTextStyle),
                          Column(
                            children: [
                              StatLinearIndicator(
                                stat: 'Max HP',
                                value: pokemonStats['hitPoints']!,
                                maxValue: pokemonMaxStats['hitPoints']!,
                                color: brightColor!,
                              ),
                              StatLinearIndicator(
                                stat: 'Attack',
                                value: pokemonStats['attack']!,
                                maxValue: pokemonMaxStats['attack']!,
                                color: brightColor!,
                              ),
                              StatLinearIndicator(
                                stat: 'Defense',
                                value: pokemonStats['defense']!,
                                maxValue: pokemonMaxStats['defense']!,
                                color: brightColor!,
                              ),
                              StatLinearIndicator(
                                stat: 'Sp. Atk',
                                value: pokemonStats['specialAtk']!,
                                maxValue: pokemonMaxStats['specialAtk']!,
                                color: brightColor!,
                              ),
                              StatLinearIndicator(
                                stat: 'Sp. Def',
                                value: pokemonStats['specialDef']!,
                                maxValue: pokemonMaxStats['specialDef']!,
                                color: brightColor!,
                              ),
                              StatLinearIndicator(
                                stat: 'Speed',
                                value: pokemonStats['speed']!,
                                maxValue: pokemonMaxStats['speed']!,
                                color: brightColor!,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Text('Abilities', style: kHeaderTextStyle),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                pokemonAbilityBuilder(),
                          ),
                          const SizedBox(height: 15),
                          const Text('Weaknesses', style: kHeaderTextStyle),
                          const Row(
                            children: [
                              PokemonTypeBox(type: 'electric'),
                              PokemonTypeBox(type: 'grass'),
                            ],
                          ),
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
