import 'package:flutter/cupertino.dart';

class ColumnCell extends StatelessWidget {
  final dynamic data;
  const ColumnCell({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url = data["url"].toString();
    String baseUrl = "https://pokeapi.co/api/v2/pokemon/";
    String result = url.replaceAll(baseUrl, "").replaceAll("/", "");
    return Container(
      width: double.infinity,
      height: 100,
      color: const Color.fromARGB(255, 41, 226, 211),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image.network(
                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$result.png"),
          ),
          Text(data["name"].toString()),
        ],
      ),
    );
  }
}
