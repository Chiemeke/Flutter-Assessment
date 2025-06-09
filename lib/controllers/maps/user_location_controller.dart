import 'dart:math';
import 'package:delivery_app/models/user_location_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;

class UserLocationController extends Notifier<UserLocationModel> {
  late MapboxMap _mapboxMap;
  PointAnnotationManager? _annotationManager;

  @override
  UserLocationModel build() {
    return UserLocationModel(
      cameraOptions: CameraOptions(
        center: mapbox.Point(
            coordinates: mapbox.Position(-122.4194, 37.7749)), // default to SF
      ),
      markers: const [],
    );
  }

  void onMapCreated(MapboxMap mapboxMap) {
    _mapboxMap = mapboxMap;
    _mapboxMap.annotations.createPointAnnotationManager().then((manager) {
      _annotationManager = manager;
      startUserLocationTracking();
    });
  }

  void startUserLocationTracking() {
    var locationSettings = geo.LocationSettings(
      accuracy: geo.LocationAccuracy.high,
      distanceFilter: 5,
    );

    geo.Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (position) async {
        final center = mapbox.Point(
          coordinates: mapbox.Position(position.longitude, position.latitude),
        );
        final camera = CameraOptions(center: center, zoom: 16.5);
        _mapboxMap.setCamera(camera);
        state = state.copyWith(cameraOptions: camera);
        await getMarkedLocations(position);
      },
    );
  }

  Future<void> getMarkedLocations(geo.Position userPosition) async {
    final markers = await _createNearbyMarkers(userPosition);
    final camera = CameraOptions(
      center: mapbox.Point(
        coordinates:
            mapbox.Position(userPosition.longitude, userPosition.latitude),
      ),
      zoom: 16.5,
    );
    state = state.copyWith(cameraOptions: camera, markers: markers);
  }

  Future<List<PointAnnotation>> _createNearbyMarkers(
      geo.Position userPosition) async {
    final manager = _annotationManager;
    if (manager == null) return [];

    final nearbyLocations =
        _generateNearbyLocations(userPosition, count: 5, radiusInMeters: 3);

    List<PointAnnotation> annotations = [];
    for (var loc in nearbyLocations) {
      final point = mapbox.Point(
        coordinates:
            mapbox.Position(loc['latLng'].longitude, loc['latLng'].latitude),
      );
      final annotation = await manager.create(PointAnnotationOptions(
        geometry: point,
        textField: loc['title'],
        textOffset: [0, 2],
        iconSize: 1.5,
      ));
      annotations.add(annotation);
    }
    return annotations;
  }

  List<Map<String, dynamic>> _generateNearbyLocations(
    geo.Position userPosition, {
    required int count,
    required double radiusInMeters,
  }) {
    final R = 6371000.0; // Earth radius in meters
    final lat = userPosition.latitude * pi / 180;
    final lon = userPosition.longitude * pi / 180;

    List<Map<String, dynamic>> results = [];
    final random = Random();

    for (int i = 0; i < count; i++) {
      final angle = random.nextDouble() * 2 * pi;
      final dist = random.nextDouble() * radiusInMeters;

      final dLat = dist * cos(angle) / R;
      final dLon = dist * sin(angle) / (R * cos(lat));

      final newLat = lat + dLat;
      final newLon = lon + dLon;

      results.add({
        'latLng': geo.Position(
          latitude: newLat * 180 / pi,
          longitude: newLon * 180 / pi,
          timestamp: DateTime.now(),
          accuracy: 5.0,
          altitude: 0.0,
          altitudeAccuracy: 5.0,
          heading: 0.0,
          headingAccuracy: 5.0,
          speed: 0.0,
          speedAccuracy: 1.0,
          isMocked: true,
        ),
        'title': 'Nearby Point ${i + 1}',
      });
    }

    return results;
  }
}
