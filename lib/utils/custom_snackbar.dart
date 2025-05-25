import 'package:flutter/material.dart';

class CustomSnackbar {
  static GlobalKey<ScaffoldMessengerState> messagekey =
      GlobalKey<ScaffoldMessengerState>();
  static showSnackbar(String text, Color color, IconData icon) {
    if (text.isEmpty) return;

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Container(
        height: 30,
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 250,
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                )),
            Icon(
              icon,
              color: Colors.white,
            ),
          ],
        ),
      ),
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      backgroundColor: color,
      dismissDirection: DismissDirection.startToEnd,
      elevation: 10,
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
    );
    // final _successSnakBar = SnackBar(content: Text(text), backgroundColor: Colors.green, );

    messagekey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
