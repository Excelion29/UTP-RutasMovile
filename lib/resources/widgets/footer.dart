import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color.fromARGB(255, 255, 255, 255),
      child: const Text(
        '© 2024 Your Company',
        style: TextStyle(color: Color.fromARGB(255, 170, 170, 170)),
        textAlign: TextAlign.center,
      ),
    );
  }
}