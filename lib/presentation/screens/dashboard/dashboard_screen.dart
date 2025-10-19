import 'package:cold_storage/presentation/screens/inbound/inbound_screen.dart';
import 'package:cold_storage/presentation/screens/inventory/inventory_screen.dart';
import 'package:cold_storage/presentation/widget/temperature_card.dart';
import 'package:cold_storage/providers/temperature_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    final tempProvider = context.read<TemperatureProvider>();
    tempProvider.startPolling();
  }

  @override
  void dispose() {
    context.read<TemperatureProvider>().stopPolling();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tempProvider = context.watch<TemperatureProvider>();
    final rooms = tempProvider.rooms;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cold Storage Dashboard"),
      ),
      body: rooms.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => tempProvider.fetchTemperatures(),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return TemperatureCard(room: room);
                },
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_box_outlined),
                label: const Text("Inbound"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const InboundScreen()),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.list_alt),
                label: const Text("Inventory"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const InventoryScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
