import 'package:flutter/material.dart';

class MenuItemName extends StatelessWidget {
  final String itemName;
  const MenuItemName({Key? key, required this.itemName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Chip(
        label: Text(itemName),
        labelPadding: const EdgeInsets.all(4),
        backgroundColor: const Color.fromRGBO(255, 218, 218, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}