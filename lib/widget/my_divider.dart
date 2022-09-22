import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Color.fromRGBO(255, 175, 175, 0.8),
      thickness: 1,
      height: 24,
      indent: 5,
      endIndent: 5,
    );
  }
}
