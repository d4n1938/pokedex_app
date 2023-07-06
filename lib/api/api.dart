import 'package:http/http.dart' as http;

Future getAllPokemon() async {
  return http.get(Uri.parse(
      'https://pokeapi.co/api/v2/pokemon?limit=151&offset=0/language/1/'));
}

Future getJapaneseName(String nom) async {
  return http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-species/$nom/'));
}
