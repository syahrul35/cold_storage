import 'package:cold_storage/data/models/location.dart';
import 'package:cold_storage/domain/repositories/inventory_repository.dart';
import 'package:flutter/foundation.dart';

class LocationProvider extends ChangeNotifier {
  final _service = MockService();
  List<Location> locations = [];

  Future<void> fetchLocations() async {
    final data = await _service.getLocations();
    locations = data.map((e) => Location.fromJson(e)).toList();
    notifyListeners();
  }
}
