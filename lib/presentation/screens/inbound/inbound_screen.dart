import 'package:cold_storage/data/models/item.dart';
import 'package:cold_storage/data/models/location.dart';
import 'package:cold_storage/providers/inventory_provider.dart';
import 'package:cold_storage/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InboundScreen extends StatefulWidget {
  const InboundScreen({super.key});

  @override
  State<InboundScreen> createState() => _InboundScreenState();
}

class _InboundScreenState extends State<InboundScreen> {
  final _formKey = GlobalKey<FormState>();

  final _skuController = TextEditingController();
  final _batchController = TextEditingController();
  final _qtyController = TextEditingController();
  DateTime? _expiry;
  Location? _selectedLocation;

  @override
  void initState() {
    super.initState();
    context.read<LocationProvider>().fetchLocations();
  }

  @override
  void dispose() {
    _skuController.dispose();
    _batchController.dispose();
    _qtyController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate() || _selectedLocation == null) return;

    final location = _selectedLocation!;
    final newItem = Item(
      sku: _skuController.text,
      batch: _batchController.text,
      expiry: _expiry!,
      qty: int.parse(_qtyController.text),
      location: location,
    );

    context.read<InventoryProvider>().addItem(newItem);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Item added to inventory")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationProvider>();
    final locations = locationProvider.locations;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inbound Item"),
      ),
      body: locations.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _skuController,
                            decoration: const InputDecoration(
                              labelText: "SKU",
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) =>
                                v == null || v.isEmpty ? "Required" : null,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.qr_code),
                          label: const Text("Scan"),
                          onPressed: () {
                            setState(() {
                              _skuController.text = "SKU-${DateTime.now().millisecondsSinceEpoch}";
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _batchController,
                      decoration: const InputDecoration(
                        labelText: "Batch",
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? "Required" : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _qtyController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Quantity",
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return "Required";
                        final value = int.tryParse(v);
                        if (value == null || value <= 0) return "Invalid qty";
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      title: Text(
                        _expiry == null
                            ? "Select Expiry Date"
                            : "Expiry: ${_expiry!.toLocal().toString().split(' ')[0]}",
                      ),
                      trailing: const Icon(Icons.calendar_month),
                      onTap: () async {
                        final now = DateTime.now();
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: now,
                          lastDate: now.add(const Duration(days: 365 * 5)),
                        );
                        if (picked != null) setState(() => _expiry = picked);
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<Location>(
                      decoration: const InputDecoration(
                        labelText: "Location",
                        border: OutlineInputBorder(),
                      ),
                      items: locations.map((loc) {
                        return DropdownMenuItem(
                          value: loc,
                          child: Text(loc.label),
                        );
                      }).toList(),
                      onChanged: (loc) => setState(() => _selectedLocation = loc),
                      validator: (v) =>
                          v == null ? "Select a location" : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: Text(
                        _selectedLocation?.isFull == true
                            ? "Full location"
                            : "Submit",
                      ),
                      onPressed: _selectedLocation?.isFull == true
                          ? null
                          : _submitForm,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
