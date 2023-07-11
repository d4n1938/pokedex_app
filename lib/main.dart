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
  dynamic _data;
  dynamic req;

  @override
  void initState() {
    req = allPokemon().then((value) => {
          setState(() {
            _data = value;
          })
        });
    super.initState();
  }

  List<Widget> _getItems() {
    final List<Widget> todoWidgets = <Widget>[];
    for (dynamic list in _data) {
      todoWidgets.add(ColumnCell(
        data: list,
      ));
    }
    return todoWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: req,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: _getItems(),
                );
              } else {
                return Image.asset("images/splash.png");
              }
            }),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 100,
        height: 100,
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Image.asset(
            "/images/splash.png",
          ),
          onPressed: () {},
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
  debugPrint(json["names"][0]["name"]);
  final String res = json["names"][0]["name"].toString();
  return res;
}
