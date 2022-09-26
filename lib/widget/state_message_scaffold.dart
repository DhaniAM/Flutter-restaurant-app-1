import 'package:flutter/material.dart';

class StateMessageScaffold extends StatelessWidget {
  final IconData icon;
  final String text;
  const StateMessageScaffold({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
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
      ),
    );
  }
}
