import 'package:delivery_app/providers/map_providers.dart';
import 'package:delivery_app/shared/Utils/device_permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class Maps extends ConsumerStatefulWidget {
  const Maps({super.key});

  @override
  ConsumerState<Maps> createState() => _MapsState();
}

class _MapsState extends ConsumerState<Maps> {
  late final MapboxMap mapboxController;

  @override
  void initState() {
    super.initState();
    getUserInitPosition();
  }

  Future<void> getUserInitPosition() async {
    String? response = await DevicePermissions().handleLocationPermission();
    if (response == null) {
      // Permissions granted, no need to call anything extra here.
    }
  }

  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(mapProvider);
    return Scaffold(
      body: MapWidget(
        onMapCreated: (controller) {
          mapboxController = controller;
          ref.read(mapProvider.notifier).onMapCreated(controller);
        },
        cameraOptions: mapState.cameraOptions,
      ),
    );
  }
}
