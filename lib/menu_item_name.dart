import 'package:flutter/material.dart';

class MenuItemName extends StatelessWidget {
  const MenuItemName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text("Food Name"),
      padding: EdgeInsets.all(10),
      backgroundColor: Color.fromRGBO(255, 218, 218, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
