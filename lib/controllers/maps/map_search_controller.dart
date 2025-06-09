import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapSearchController extends Notifier<int> {
  @override
  int build() {
    return 160;
  }

  void mapSearchControllerState(
      {required FocusNode focusNode,
      required TextEditingController searchController,
      }) {
    if (searchController.text.isEmpty && !focusNode.hasFocus) {
      state = 106;
    } else if (searchController.text.isNotEmpty && !focusNode.hasFocus) {
      state = 446;
    } else if (searchController.text.isNotEmpty && focusNode.hasFocus) {
      state = 246;
    } else {
      state = 160;
    }
  }
}
