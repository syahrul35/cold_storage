import 'dart:async';
import 'package:cold_storage/data/mock_data/mock_service.dart';
import 'package:cold_storage/data/models/location.dart';
import 'package:cold_storage/data/models/temperature.dart';

class InventoryRepository {
  final _service = MockService();

  Future<List<Temperature>> getTemperatures() async {
    final data = await _service.getTemperatures();
    return data.map((e) => Temperature.fromJson(e)).toList();
  }

  Future<List<Location>> getLocations() async {
    final data = await _service.getLocations();
    return data.map((e) => Location.fromJson(e)).toList();
  }
}