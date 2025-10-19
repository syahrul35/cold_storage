import 'package:cold_storage/data/models/location.dart';

class Item {
  final String sku;
  final String batch;
  final DateTime expiry;
  final int qty;
  final Location location;

  Item({
    required this.sku,
    required this.batch,
    required this.expiry,
    required this.qty,
    required this.location,
  });

  bool get isNearExpiry =>
      expiry.difference(DateTime.now()).inDays < 30;
}
