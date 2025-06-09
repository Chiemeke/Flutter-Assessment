import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message,
    {bool showUndo = false}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        Expanded(child: Text(message)),
        if (showUndo)
          TextButton(
            onPressed: () {
              // handle undo
            },
            child: const Text(
              'UNDO',
              style: TextStyle(color: Colors.greenAccent),
            ),
          ),
      ],
    ),
    backgroundColor: Colors.black87,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
