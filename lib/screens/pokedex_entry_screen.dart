import 'package:flutter/material.dart';
import 'package:flutter_pokedex/utils/constants.dart';
import 'package:flutter_pokedex/utils/helper_functions.dart';
import 'package:flutter_pokedex/services/pokeapi_service.dart';
import 'package:flutter_pokedex/widgets/pokemon_type_box.dart';

// TODO: Add flavor text, stats, and weaknesses

class PokedexEntryScreen extends StatefulWidget {
  const PokedexEntryScreen({super.key, required this.pokemonData});

  final Map pokemonData;

  @override
  State<PokedexEntryScreen> createState() => _PokedexEntryScreenState();
}

class _PokedexEntryScreenState extends State<PokedexEntryScreen> {
  final PokeApiService _pokeApiService = PokeApiService();
  Map<String, dynamic> pokemonData = {
    'id': null,
    'name': null,
    'pokemonTypes': [],
    'image': null,
    'flavorText': null,
    'height': null,
    'weight': null,
    // 'hitPoints': null,
    // 'attack': null,
    // 'defense': null,
    // 'specialAtk': null,
    // 'specialDef': null,
    // 'speed': null,
  };
  Color? brightColor;
  Color? darkColor;
  bool _isLoading = true;


  Future<void> loadPokedexEntry() async {
    print(_isLoading);
    pokemonData['id'] = formatPokemonID(widget.pokemonData['id']);
    String name = widget.pokemonData['name'];
    pokemonData['name'] = name.capitalize();
    pokemonData['pokemonTypes'] = getPokemonTypes(widget.pokemonData['types']);
    pokemonData['primaryType'] = pokemonData['pokemonTypes'][0];
    brightColor = brightColors[pokemonData['primaryType']];
    darkColor = darkColors[pokemonData['primaryType']];
    pokemonData['image'] = widget.pokemonData['sprites']['front_default'];
    String flavorText = await _pokeApiService.getPokemonFlavorText(
        id: widget.pokemonData['id']);
    pokemonData['flavorText'] = flavorText.replaceAll('\n', ' ');
    String height = '${(widget.pokemonData['height'] / 3.048).toStringAsFixed(2)}\"';
    pokemonData['height'] = height.replaceAll('.','\' ');
    pokemonData['weight'] = '${(widget.pokemonData['weight'] / 4.536).toStringAsFixed(2)} lbs';
    print('!!! DEBUG !!!');
    // print(pokemonData['stats'][0]['base_stat']);
    // pokemonData['hitPoints'] = pokemonData['stats'][0]['base_stat'];
    // pokemonData['attack'] = pokemonData['stats'][1]['base_stat'];
    // pokemonData['defense'] = pokemonData['stats'][2]['base_stat'];
    // pokemonData['specialAtk'] = pokemonData['stats'][3]['base_stat'];
    // pokemonData['specialDef'] = pokemonData['stats'][4]['base_stat'];
    // pokemonData['speed'] = pokemonData['stats'][5]['base_stat'];
    setState(() {
      _isLoading = false;
    });
    print(_isLoading);
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

  @override
  void initState() {
    // TODO: implement initState
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
                          Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: AspectRatio(
                                    aspectRatio: 1 / 1,
                                    child: Image(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        pokemonData['image'],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        pokemonData['id'],
                                        style: kGrayDefaultTextStyle),
                                    Text(pokemonData['name'],
                                        style: kTitleTextStyle),
                                    Row(
                                      children: pokemonTypeCardBuilder(pokemonData['pokemonTypes']),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            pokemonData['flavorText'],
                            style: kLightGrayDefaultTextStyle,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              PhysicalQuantityCard(
                                quantity: pokemonData['height'],
                                type: 'HEIGHT',
                              ),
                              PhysicalQuantityCard(
                                quantity: pokemonData['weight'],
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
                                value: 268,
                                maxValue: 362,
                                color: brightColor!,
                              ),
                              StatLinearIndicator(
                                stat: 'Attack',
                                value: 153,
                                maxValue: 292,
                                color: brightColor!,
                              ),
                              StatLinearIndicator(
                                stat: 'Defense',
                                value: 184,
                                maxValue: 328,
                                color: brightColor!,
                              ),
                              StatLinearIndicator(
                                stat: 'Sp. Atk',
                                value: 157,
                                maxValue: 295,
                                color: brightColor!,
                              ),
                              StatLinearIndicator(
                                stat: 'Sp. Def',
                                value: 193,
                                maxValue: 339,
                                color: brightColor!,
                              ),
                              StatLinearIndicator(
                                stat: 'Speed',
                                value: 144,
                                maxValue: 280,
                                color: brightColor!,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Text('Weaknesses', style: kHeaderTextStyle),
                          const Row(
                            children: [
                              PokemonTypeBox(type: 'electric'),
                              PokemonTypeBox(type: 'grass'),
                            ],
                          )
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

class StatLinearIndicator extends StatelessWidget {
  const StatLinearIndicator({
    super.key,
    required this.stat,
    required this.value,
    required this.maxValue,
    required this.color,
  });

  final String stat;
  final double value;
  final double maxValue;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(stat, style: kLightGrayDefaultTextStyle),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: LinearProgressIndicator(
                color: color,
                backgroundColor: kGrayColor200,
                minHeight: 8,
                value: value / maxValue,
              ),
            ),
          ),
        ],
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
                  fontSize: 26,
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
