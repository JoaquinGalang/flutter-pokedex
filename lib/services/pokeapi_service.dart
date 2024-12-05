import 'dart:convert';

import 'package:http/http.dart' as http;

class PokeApiService {
  final String urlPrefix = 'https://pokeapi.co/api/v2';

  dynamic getPokemonData({required int id}) async {
    print('$urlPrefix/pokemon/$id');
    var url = Uri.parse('$urlPrefix/pokemon/$id');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    return jsonData;
  }

  dynamic getPokemonFlavorText({required int id}) async {
    var url = Uri.parse('$urlPrefix/pokemon-species/$id');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    return jsonData['flavor_text_entries'][0]['flavor_text'];
  }

}