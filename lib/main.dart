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
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromARGB(255, 255, 0, 0),
      ),
      home: const MyHomePage(),
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

  double _bottomBarHeight = 50;

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
      body: Stack(
        children: [
          Center(
            child: FutureBuilder(
                future: req,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: _getItems(),
                    );
                  } else {
                    return Image.asset(
                      "assets/icons/splash.png",
                      width: 200,
                    );
                  }
                }),
          ),
          Positioned(
            bottom: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 0, 0),
                  borderRadius: _bottomBarHeight != 50
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))
                      : BorderRadius.zero),
              width: MediaQuery.of(context).size.width,
              height: _bottomBarHeight,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      cursorColor: Colors.red,
                      style: const TextStyle(
                          fontSize: 20,
                          height: 1,
                          color: Color.fromARGB(255, 24, 24, 24)),
                      decoration: InputDecoration(
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(right: 15.0),
                            child: Icon(Icons.search,
                                size: 30,
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          AnimatedPositioned(
            bottom: _bottomBarHeight - 50,
            right: MediaQuery.of(context).size.width / 2 - 50,
            duration: const Duration(milliseconds: 150),
            child: SizedBox(
              width: 100,
              height: 100,
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  "assets/images/splash.png",
                ),
                onPressed: () {
                  setState(() {
                    _bottomBarHeight == 50
                        ? _bottomBarHeight = 300
                        : _bottomBarHeight = 50;
                  });
                },
              ),
            ),
          )
        ],
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
  final allPokemon = await getPokemonDetail(nom);
  final json = jsonDecode(allPokemon.body);
  debugPrint(json["names"][0]["name"]);
  final String res = json["names"][0]["name"].toString();
  return res;
}
