import 'dart:convert';
import '../models/Pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonController {
  final String url = "https://pokeapi.co/api/v2/pokemon";

  Future<List<Pokemon>> getPokemons() async {
    List<Pokemon> pokemons = [];
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> json = jsonDecode(response.body);
    if(response.statusCode != 200) {
      throw Exception("Error al consumir el API");
    }
    return pokemons;
  }  
  
}