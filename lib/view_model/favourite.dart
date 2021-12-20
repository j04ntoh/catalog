import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:catalog/model/cart.dart';
import 'package:catalog/view/thumbnail.dart' as thumb;

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    // debugPrint("hello " + cart.itemCount.toString());
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              ),
              itemCount: cart.itemCount,
              itemBuilder: (BuildContext context, int index) {
                int checkOrientation =
                    orientation == Orientation.portrait ? 2 : 3;
                return thumb.Thumbnail(
                    ObjectKey(cart.items.values.toList()[index].imgId),
                    index,
                    cart.items.values.toList()[index].imgId,
                    cart.items.values.toList()[index].url,
                    cart.items.values.toList()[index].title,
                    MediaQuery.of(context).size.width / checkOrientation - 10);
              });
        },
      ),
    );
  }
}
