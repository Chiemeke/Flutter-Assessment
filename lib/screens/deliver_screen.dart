import 'package:delivery_app/shared/widgets/maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../providers/delivery_provider.dart';

class DeliveryScreen extends ConsumerStatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends ConsumerState<DeliveryScreen> {
  late MapboxMap mapboxMap;
  PointAnnotationManager? pointAnnotationManager;

  @override
  Future<void> _onMapCreated(MapboxMap map) async {
    mapboxMap = map;

    // Create the annotation manager
    pointAnnotationManager =
        await mapboxMap.annotations.createPointAnnotationManager();

    final delivery = ref.read(deliveryProvider);

    // Clear any existing annotations
    await pointAnnotationManager?.deleteAll();

    // Add pickup marker
    await pointAnnotationManager?.create(PointAnnotationOptions(
      geometry: Point(
        coordinates: Position(delivery.pickupLng, delivery.pickupLat),
      ),
      iconImage:
          'pickup_marker', // make sure this icon is added in style or as image source
      iconSize: 1.5,
    ));

    // Add delivery marker
    await pointAnnotationManager?.create(PointAnnotationOptions(
      geometry: Point(
        coordinates: Position(delivery.deliveryLng, delivery.deliveryLat),
      ),
      iconImage: 'delivery_marker',
      iconSize: 1.5,
    ));

    // Move camera to center between pickup and delivery
    final centerLng = (delivery.pickupLng + delivery.deliveryLng) / 2;
    final centerLat = (delivery.pickupLat + delivery.deliveryLat) / 2;

    await mapboxMap.easeTo(
      CameraOptions(
        center: Point(coordinates: Position(centerLng, centerLat)),
        zoom: 12,
      ),
      MapAnimationOptions(duration: 2000, startDelay: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delivery Detail')),
      body: Maps(),
    );
  }
}
