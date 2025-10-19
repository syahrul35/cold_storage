import 'package:cold_storage/data/models/temperature.dart';
import 'package:flutter/material.dart';

class TemperatureCard extends StatelessWidget {
  final Temperature room;

  const TemperatureCard({super.key, required this.room});

  bool get isOutOfRange => room.temperature < -20 || room.temperature > -16;

  @override
  Widget build(BuildContext context) {
    final color = isOutOfRange ? Colors.red[100] : Colors.green[50];
    final borderColor = isOutOfRange ? Colors.red : Colors.green;

    return Card(
      color: color,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          Icons.ac_unit,
          color: isOutOfRange ? Colors.red : Colors.blue,
        ),
        title: Text(
          room.roomId,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text("${room.temperature.toStringAsFixed(1)} °C"),
        trailing: isOutOfRange
            ? const Icon(Icons.warning, color: Colors.red)
            : const Icon(Icons.check_circle, color: Colors.green),
      ),
    );
  }
}
