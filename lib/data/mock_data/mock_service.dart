import 'dart:async';

class MockService {
  Future<List<Map<String, dynamic>>> getTemperatures() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      {"room_id": "COLD-01", "temperature": -18.3, "timestamp": DateTime.now().toIso8601String()},
      {"room_id": "COLD-02", "temperature": -15.8, "timestamp": DateTime.now().toIso8601String()},
      {"room_id": "COLD-03", "temperature": -19.5, "timestamp": DateTime.now().toIso8601String()},
    ];
  }

  Future<List<Map<String, dynamic>>> getLocations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {"id": "A1-01", "label": "Zone A / Rack 1 / Slot 01", "capacity": 100, "current_load": 72},
      {"id": "A1-02", "label": "Zone A / Rack 1 / Slot 02", "capacity": 120, "current_load": 120},
      {"id": "B2-05", "label": "Zone B / Rack 2 / Slot 05", "capacity": 80, "current_load": 30},
    ];
  }
}
