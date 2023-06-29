import 'package:http/http.dart' as http;

Future getAllPokemon() async {
  return http
      .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=1020&offset=0'));
}
