import 'dart:convert';

import 'package:flutter/material.dart';

import 'api/api.dart';

class Detail extends StatefulWidget {
  final String id;
  final String name;
  const Detail({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String data = "";

  @override
  initState() {
    super.initState();
    getPokemonDetail(widget.id).then((value) =>
        getFlavorText(value).then((value) => setState(() => data = value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: SizedBox(
              width: 400,
              child: Hero(
                tag: "pokemon${widget.id}",
                child: Image.network(
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${widget.id}.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Text("No.${widget.id}   ${widget.name}",
              style: const TextStyle(fontSize: 30)),
          const SizedBox(
            height: 20,
          ),
          Text(data)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        child: Container(
          color: const Color.fromARGB(255, 255, 0, 0),
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          // Add your onPressed code here!
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Color.fromARGB(255, 255, 0, 0),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Color.fromARGB(255, 255, 0, 0),
              ),
              label: ''),
        ],
      ),
    );
  }
}

Future<String> getFlavorText(dynamic json) async {
  dynamic flavors = jsonDecode(json.body)["flavor_text_entries"];
  List<dynamic> jpTexts = [];
  for (dynamic flavor in flavors) {
    if (flavor["language"]["name"] == "ja") {
      debugPrint(flavor["flavor_text"]);
      jpTexts.add(flavor);
    }
  }
  String data = jpTexts[0]["flavor_text"].toString();
  return data;
}
