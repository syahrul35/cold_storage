class Location {
  final String id;
  final String label;
  final int capacity;
  final int currentLoad;

  Location({
    required this.id,
    required this.label,
    required this.capacity,
    required this.currentLoad,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      label: json['label'],
      capacity: json['capacity'],
      currentLoad: json['current_load'],
    );
  }

  bool get isFull => currentLoad >= capacity;
}
