import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
    );

    messengerKey.currentState!.showSnackBar(snackbar);
  }
}
