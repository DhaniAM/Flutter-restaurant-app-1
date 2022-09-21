import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/searchScreen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  /// to Notify listener everytime text updated
  final TextEditingController _controller = TextEditingController();

  bool searchState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 106, 106, 1),

        /// Input Text
        title: TextField(
          controller: _controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Search restaurant, tag, menu...",
            hintStyle: TextStyle(color: Colors.white),
          ),
          onChanged: (value) {
            setState(() {
              searchState = true;
            });
          },
          onSubmitted: (value) {
            setState(() {
              searchState = false;
            });
          },
        ),

        /// Search Button
        actions: <Widget>[
          /// if not in [searchState], hide search button or if input is empty
          (searchState == false || _controller.text.isEmpty)
              ? SizedBox()
              : IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {
                    setState(() {
                      /// Hide search button
                      searchState = false;

                      /// Close keyboard
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                )
        ],
      ),
      body: Text('inputValue'),
    );
  }
}
