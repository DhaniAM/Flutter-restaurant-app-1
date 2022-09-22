import 'package:flutter/material.dart';

class StateMessage extends StatelessWidget {
  final IconData icon;
  final String text;
  const StateMessage({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 200,
            color: const Color.fromARGB(255, 221, 221, 221),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
