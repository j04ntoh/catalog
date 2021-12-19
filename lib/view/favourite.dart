import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' ;
 

class Favourite extends StatefulWidget {
  const Favourite({ Key? key }) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeRight,
      // DeviceOrientation.landscapeLeft,
      // DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown
    // ]);
  }
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favourite")),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            // Create a grid with 2 columns in portrait mode, or 3 columns in
            // landscape mode.
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(100, (index) {
              return Center(
                child: Text(
                  'Item $index',
                  style: Theme.of(context).textTheme.headline1,
                ),
              );
            }),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      )
    );
  }
}