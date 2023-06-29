import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex/api/api.dart';

import 'column_cell.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic _data = "";

  @override
  void initState() {
    AllPokemon().then((value) => {
          setState(() {
            _data = value;
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              if (_data != "")
                for (dynamic list in _data)
                  ColumnCell(
                    data: list,
                  )
            ],
          ),
        ),
      ),
    );
  }
}

Future AllPokemon() async {
  final allPokemon = await getAllPokemon();
  final jsonAllPokemon = jsonDecode(allPokemon.body);
  final res = jsonAllPokemon["results"];
  return res;
}
