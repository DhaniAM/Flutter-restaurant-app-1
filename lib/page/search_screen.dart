import 'package:flutter/material.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/widget/restaurants_list_result.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/searchScreen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  /// to Notify listener everytime text updated and to get the Input value
  final TextEditingController _controller = TextEditingController();
  bool searchState = false;
  bool hasData = false;
  late Future<RestaurantsList> restaurantsList;

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
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            hintText: "Search restaurant, tag, menu...",
            hintStyle: TextStyle(color: Colors.white),
          ),

          /// Everytime user type a letter, this onChanged get called and
          /// [_controller] also get called
          onChanged: (value) {
            setState(() {
              searchState = true;
            });
          },
          onSubmitted: (value) {
            setState(() {
              searchState = false;
              if (value != "") {
                restaurantsList =
                    ApiService().getSearchResults(_controller.text);
                hasData = true;
              }
            });
          },
        ),

        /// Search Button
        actions: <Widget>[
          /// if not in [searchState], hide search button or if input is empty
          (searchState == false || _controller.text.isEmpty)
              ? const SizedBox()
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

      /// Search Result
      body: hasData == false
          ? Center(
              child: Icon(
                Icons.fastfood,
                size: 200,
                color: Color.fromARGB(255, 206, 206, 206),
              ),
            )
          : RestaurantListResult(restaurantsList: restaurantsList),

      // body: Center(
      //   child: Text(_controller.text),
      // ),
    );
  }
}
