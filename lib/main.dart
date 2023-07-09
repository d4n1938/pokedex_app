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
    allPokemon().then((value) => {
          setState(() {
            _data = value;
          })
        });
    super.initState();
  }

  List<Widget> _getItems() {
    final List<Widget> todoWidgets = <Widget>[];
    for (dynamic list in _data) {
      todoWidgets.add(Container(
          child: ColumnCell(
        data: list,
      )));
    }
    return todoWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: _getItems(),
        ),
      ),
    );
  }
}

Future allPokemon() async {
  final allPokemon = await getAllPokemon();
  final jsonAllPokemon = jsonDecode(allPokemon.body);
  final res = jsonAllPokemon["results"];
  return res;
}

Future<String> getJpName(String nom) async {
  final allPokemon = await getJapaneseName(nom);
  final json = jsonDecode(allPokemon.body);
  print(json["names"][0]["name"]);
  final String res = json["names"][0]["name"].toString();
  return res;
}
