import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:catalog/model/cart.dart';
import 'package:catalog/model/catapi.dart';

Future<CatAPI> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('https://api.thecatapi.com/v1/images/search'));

  if (response.statusCode == 200) {
    return CatAPI.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<CatAPI> futureAlbum;

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

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    // debugPrint("hello " + cart.itemCount.toString());

    return Scaffold(
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
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              onPressed: loadNewItem,
              child: const Icon(Icons.refresh),
            ),
            FloatingActionButton(
              onPressed: () async {
                CatAPI catDetail = await futureAlbum;
                debugPrint("hello cat id " + catDetail.id);
                cart.addItem(catDetail.id, catDetail.url, "No Name");
                //
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Added item to favourite.'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      // ignore_for_file: avoid_print
                      print("pressed undo");
                      // cart.removeSingleItem(catAPI.id);
                    },
                  ),
                ));
              },
              child: const Icon(Icons.favorite_border_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
