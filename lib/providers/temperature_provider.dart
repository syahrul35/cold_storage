import 'dart:async';
import 'package:cold_storage/data/models/temperature.dart';
import 'package:cold_storage/domain/repositories/inventory_repository.dart';
import 'package:flutter/foundation.dart';

class TemperatureProvider extends ChangeNotifier {
  final _service = InventoryRepository();
  List<Temperature> rooms = [];
  Timer? _timer;

  Future<void> fetchTemperatures() async {
    rooms = await _service.getTemperatures();
    notifyListeners();
  }

  void startPolling() {
    fetchTemperatures();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => fetchTemperatures());
  }

  void stopPolling() {
    _timer?.cancel();
  }
}
