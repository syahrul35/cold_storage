class Temperature {
  final String roomId;
  final double temperature;
  final DateTime timestamp;

  Temperature({
    required this.roomId,
    required this.temperature,
    required this.timestamp,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      roomId: json['room_id'],
      temperature: (json['temperature'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}