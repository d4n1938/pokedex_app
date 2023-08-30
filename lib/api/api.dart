import 'package:http/http.dart' as http;

Future getAllPokemon() async {
  return http.get(Uri.parse(
      'https://pokeapi.co/api/v2/pokemon?limit=1050&offset=0/language/1/'));
}

Future getPokemonDetail(String nom) async {
  return http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-species/$nom/'));
}
