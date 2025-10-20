import 'package:cold_storage/data/models/location.dart';
import 'package:cold_storage/domain/repositories/inventory_repository.dart';
import 'package:flutter/foundation.dart';

class LocationProvider extends ChangeNotifier {
  final _service = InventoryRepository();
  List<Location> locations = [];

  Future<void> fetchLocations() async {
    locations = await _service.getLocations();
    notifyListeners();
  }
}
