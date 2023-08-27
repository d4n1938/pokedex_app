import 'dart:convert';

import 'package:flutter/material.dart';

import 'api/api.dart';
import 'main.dart';

class Detail extends StatefulWidget {
  final String id;
  const Detail({Key? key, required this.id}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String data = "";
  String name = "";

  @override
  initState() {
    super.initState();
    getJapaneseName(widget.id).then((value) => {
          setState(() => data = jsonDecode(value.body)["flavor_text_entries"]
                  [30]["flavor_text"]
              .toString())
        });
    getJpName(widget.id).then(
      (value) => setState(() => name = value),
    );
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
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${widget.id}.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Text("No.${widget.id}   $name", style: const TextStyle(fontSize: 30)),
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
