import 'package:flutter/material.dart';

class FavoriteListResult extends StatelessWidget {
  const FavoriteListResult({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Text('heloo');
      },
    );
  }
}
