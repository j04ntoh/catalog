import 'package:flutter/material.dart';
import 'package:catalog/view_model/cat_profile.dart';

class Thumbnail extends StatelessWidget {
  final String? id;
  final int index;
  final String title;
  final String url;
  final double thumbWidth;

  const Thumbnail(Key? key, this.index, this.id, this.url, this.title, this.thumbWidth)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            CatProfile.routeName,
            arguments: index,
          );
        },
        child: Column(
          children: <Widget>[
            Expanded(
                child: Image.network(
              url,
              width: thumbWidth,
              height: thumbWidth,
              fit: BoxFit.cover,
            )),
            const SizedBox(
              height: 10,
            ),
            Text(title)
          ],
        ));
  }
}
