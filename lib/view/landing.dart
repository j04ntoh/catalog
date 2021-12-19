import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatAPI {
  final List<dynamic> breeds;
  final String id;
  final String url;
  final int width;
  final int height;

  CatAPI({
    required this.breeds,
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory CatAPI.fromJson(List<dynamic> json) {
    // ignore_for_file: avoid_print
    print("Hello, World!" + json.first.toString());
    Map<String, dynamic> newJson = json.first;
    return CatAPI(
      breeds: newJson["breeds"],
      id: newJson['id'],
      url: newJson['url'],
      width: newJson['width'],
      height: newJson['height'],
    );
  }
}

Future<CatAPI> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('https://api.thecatapi.com/v1/images/search'));

  if (response.statusCode == 200) {
    return CatAPI.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  late Future<CatAPI> futureAlbum;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  void loadNewItem() {
    setState(() {
      futureAlbum = fetchAlbum();
    });
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cat-a-log"),
      ),
      body: Center(
        child: FutureBuilder<CatAPI>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.network(snapshot.data!.url);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.favorite_border_outlined),
            ),
            FloatingActionButton(
              onPressed: loadNewItem,
              child: const Icon(Icons.refresh),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      )
    );
  }
}
