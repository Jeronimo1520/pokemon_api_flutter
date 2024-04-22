import 'dart:convert';
import '../models/Pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonController {
  final String url = "https://pokeapi.co/api/v2/pokemon";

  Future<List<Pokemon>> getPokemons({required int offset}) async {
    List<Pokemon> pokemons = [];
    Uri uri = Uri.parse("$url?offset=$offset&limit=20");
    http.Response response = await http.get(Uri.parse(uri.toString()));
    if(response.statusCode != 200) {
      throw Exception("Error al consumir el API");
    }
    Map<String, dynamic> json = jsonDecode(response.body);
    List results = json['results'] as List;
    for(var result in results) {
      pokemons.add(Pokemon(name: result['name'], url: result['url']));
    }
    return pokemons;
  }  
  
}