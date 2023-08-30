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
  late List<dynamic> data = [];
  int version = 0;

  @override
  initState() {
    super.initState();
    getPokemonDetail(widget.id).then((value) =>
        getFlavorText(value).then((value) => setState(() => data = value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            data.isEmpty ? const Text("") : Text(data[version]["flavor_text"]),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: data.isEmpty
                  ? [Container()]
                  : List.generate(data.length, (i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 47,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(47),
                              ),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0), //色
                                width: 2.5, //太さ
                              ),
                              backgroundColor: version == i
                                  ? const Color(0xffFF6C6C)
                                  : Colors.transparent,
                            ),
                            onPressed: () {
                              setState(() {
                                version = i;
                              });
                            },
                            child: Text(data[i]["version"]["name"]),
                          ),
                        ),
                      );
                    }),
            ),
            const SizedBox(
              height: 70,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        child: Container(
          color: const Color.fromARGB(255, 255, 0, 0),
          child: const Icon(Icons.arrow_back_ios_new,
              color: Color.fromARGB(255, 255, 255, 255)),
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

Future<List<dynamic>> getFlavorText(dynamic json) async {
  dynamic flavors = jsonDecode(json.body)["flavor_text_entries"];
  List<dynamic> jpTexts = [];
  for (dynamic flavor in flavors) {
    if (flavor["language"]["name"] == "ja") {
      debugPrint(flavor["flavor_text"]);
      jpTexts.add(flavor);
    }
  }
  List<dynamic> data = jpTexts;
  return data;
}
