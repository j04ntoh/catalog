import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String? imgId;
  final String title;
  final String url;

  CartItem({required this.imgId, required this.title, required this.url});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String itemId, String url, String title) {
    debugPrint("itemId " + itemId + " " + title);
    if (_items.containsKey(itemId)) {
      _items.update(
        itemId,
        (existingCartItem) => CartItem(
          imgId: existingCartItem.imgId,
          title: title,
          url: existingCartItem.url,
        ),
      );
    } else {
      _items.putIfAbsent(
        itemId,
        () => CartItem(
          imgId: itemId,
          title: title,
          url: url,
        ),
      );
    }

    notifyListeners();
  }

  void removeSingleItem(String catId) {
    if (!_items.containsKey(catId)) {
      return;
    }
    if (_items[catId]?.imgId != null) {
      _items.update(
        catId,
        (existingCardItem) => CartItem(
          imgId: existingCardItem.imgId,
          title: existingCardItem.title,
          url: existingCardItem.url,
        ),
      );
    } else {
      _items.remove(catId);
    }
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.remove(itemId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
