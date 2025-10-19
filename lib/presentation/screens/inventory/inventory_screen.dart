import 'package:cold_storage/presentation/widget/expire_badge.dart';
import 'package:cold_storage/providers/inventory_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String _query = "";

  @override
  Widget build(BuildContext context) {
    final inventory = context.watch<InventoryProvider>();
    final items = _query.isEmpty
        ? inventory.items
        : inventory.search(_query);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventory List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Search by SKU or Location",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() => _query = val),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: items.isEmpty
                  ? const Center(child: Text("No inventory found"))
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, i) {
                        final item = items[i];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            title: Text(
                              item.sku,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                "Batch: ${item.batch}\nQty: ${item.qty}\nLocation: ${item.location.id}\nExpiry: ${item.expiry.toLocal().toString().split(' ')[0]}"),
                            trailing: item.isNearExpiry
                                ? const ExpiryBadge()
                                : null,
                          ),
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
