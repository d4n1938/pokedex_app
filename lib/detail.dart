import 'dart:convert';

import 'package:flutter/material.dart';

import 'api/api.dart';

class Detail extends StatefulWidget {
  final String id;
  const Detail({Key? key, required this.id}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String data = "";

  @override
  initState() {
    super.initState();
    getJapaneseName(widget.id).then((value) => {
          setState(() => data = jsonDecode(value.body)["flavor_text_entries"]
                  [30]["flavor_text"]
              .toString())
        });
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
          Text(data)
        ],
      ),
    );
  }
}
