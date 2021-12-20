import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:catalog/model/cart.dart';

class CatProfile extends StatefulWidget {
  static const routeName = '/cat_profile';

  const CatProfile({Key? key}) : super(key: key);

  @override
  _CatProfileState createState() => _CatProfileState();
}

class _CatProfileState extends State<CatProfile> {
  TextEditingController myController = TextEditingController();

  void _printLatestValue() {
    debugPrint('Second text field: ${myController.text}');
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final catId = ModalRoute.of(context)!.settings.arguments as int;
    final loadedProduct = cart.items.values.toList()[catId];
    myController = TextEditingController(text: loadedProduct.title);
    
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
      appBar: AppBar(
          title: TextField(controller: myController,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                decorationThickness: 0.0),
            cursorColor: Colors.white,
            // keyboardType: inputType,
            decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 0),
                hintText: "Cat name"),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                Dialog errorDialog = Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12.0)), //this right here
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("NAME SAVED"),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                String imgId = loadedProduct.imgId ?? "";
                                cart.addItem(imgId, loadedProduct.url,
                                    myController.text);
                              });
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Continue',
                            ))
                      ],
                    ),
                  ),
                );
                showDialog(
                    context: context,
                    builder: (BuildContext context) => errorDialog);
              },
            ),
          ]),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Image.network(
            loadedProduct.url,
            fit: BoxFit.contain,
          )),
        ],
      ),
    ),) ;
  }
}
