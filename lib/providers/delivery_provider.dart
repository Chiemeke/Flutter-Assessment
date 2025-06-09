import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/delivery.dart';

final deliveryProvider = Provider<Delivery>((ref) {
  return Delivery(
    recipientName: 'John Doe',
    address: '123 Main Street, City',
    status: 'In Transit',
    pickupLat: 37.7749,
    pickupLng: -122.4194,
    deliveryLat: 37.7849,
    deliveryLng: -122.4094,
  );
});
