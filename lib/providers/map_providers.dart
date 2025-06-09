import 'package:delivery_app/controllers/google_maps/user_location_controller.dart';
import 'package:delivery_app/models/user_location_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mapProvider =
    NotifierProvider<UserLocationController, UserLocationModel>(() {
  return UserLocationController();
});
