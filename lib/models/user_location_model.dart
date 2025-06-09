import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

@immutable
class UserLocationModel {
  const UserLocationModel({
    required this.cameraOptions,
    required this.markers,
  });

  final CameraOptions cameraOptions;
  final List<PointAnnotation> markers;

  UserLocationModel copyWith({
    CameraOptions? cameraOptions,
    List<PointAnnotation>? markers,
  }) {
    return UserLocationModel(
      cameraOptions: cameraOptions ?? this.cameraOptions,
      markers: markers ?? this.markers,
    );
  }
}
