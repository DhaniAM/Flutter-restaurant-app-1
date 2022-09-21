import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/searchScreen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 106, 106, 1),
        title: TextFormField(
          decoration: InputDecoration(
            suffix: GestureDetector(
              child: const Icon(Icons.search_rounded),
              onTap: () {},
            ),
            hintText: "Search restaurant name, tag, menu...",
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Icon(
          Icons.fastfood,
          size: 200,
          color: Color.fromARGB(255, 211, 211, 211),
        ),
      ),
    );
  }
}
