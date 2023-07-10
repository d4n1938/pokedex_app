import 'package:flutter/material.dart';
import 'package:pokedex/detail.dart';

import 'main.dart';

class ColumnCell extends StatefulWidget {
  final dynamic data;
  const ColumnCell({Key? key, this.data}) : super(key: key);

  @override
  State<ColumnCell> createState() => _ColumnCellState();
}

class _ColumnCellState extends State<ColumnCell> {
  String name = "";
  late String result;

  String? pokemon;
  @override
  void initState() {
    String url = widget.data["url"].toString();
    String baseUrl = "https://pokeapi.co/api/v2/pokemon/";
    setState(() {
      result = url.replaceAll(baseUrl, "").replaceAll("/", "");
    });
    getJpName(result).then(
      (value) => setState(() => name = value),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Detail(id: result);
            }));
          },
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(result.toString()),
              SizedBox(
                width: 100,
                height: 100,
                child: Hero(
                  tag: "pokemon$result",
                  child: Image.network(
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$result.png"),
                ),
              ),
              Text(name),
            ],
          ),
        ),
      ),
    );
  }
}
