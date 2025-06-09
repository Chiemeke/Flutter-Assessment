class Delivery {
  final String recipientName;
  final String address;
  final String status;
  final double pickupLat;
  final double pickupLng;
  final double deliveryLat;
  final double deliveryLng;

  Delivery({
    required this.recipientName,
    required this.address,
    required this.status,
    required this.pickupLat,
    required this.pickupLng,
    required this.deliveryLat,
    required this.deliveryLng,
  });
}
