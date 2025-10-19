import 'package:cold_storage/data/models/item.dart';
import 'package:flutter/foundation.dart';

class InventoryProvider extends ChangeNotifier {
  final List<Item> _items = [];
  List<Item> get items => _items;

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  List<Item> search(String query) {
    return _items.where((i) =>
      i.sku.toLowerCase().contains(query.toLowerCase()) ||
      i.location.id.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}
