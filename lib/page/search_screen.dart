import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/state/home_provider.dart';
import 'package:restaurant_app_1/widget/restaurants_list_result.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = "/searchScreen";
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    StateProvider provider = Provider.of<StateProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 106, 106, 1),

        /// Input Text
        title: TextField(
          controller: provider.controller,
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
          /// [controller] also get called
          onChanged: (value) {
            provider.setSearchState(true);
          },
          onSubmitted: (value) {
            provider.setSearchState(false);
            if (value != "") {
              provider.getSearchResult(provider.controller.text);
              provider.setHasData(true);
            }
          },
        ),

        /// Search Button
        actions: <Widget>[
          /// if not in [searchState], hide search button or if input is empty
          (provider.searchState == false || provider.controller.text.isEmpty)
              ? const SizedBox()
              : IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {
                    /// Hide search button
                    provider.setSearchState(false);

                    /// Close keyboard
                    FocusManager.instance.primaryFocus?.unfocus();

                    /// get Data
                    if (provider.controller.text != "") {
                      provider.getSearchResult(provider.controller.text);
                      provider.setHasData(true);
                    }
                  },
                )
        ],
      ),

      /// Search Result
      body: Consumer<StateProvider>(
        builder: (context, StateProvider value, child) {
          /// Loading State
          if (value.currentState == CurrentState.loading) {
            return const Center(
              child: CircularProgressIndicator(
                  color: Color.fromRGBO(255, 106, 106, 1)),
            );

            /// No Data State
          } else if (value.currentState == CurrentState.noData) {
            return Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.cancel,
                    size: 200,
                    color: Color.fromARGB(255, 221, 221, 221),
                  ),
                  Text(provider.message),
                ],
              ),
            );

            /// Error Data State
          } else if (value.currentState == CurrentState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_rounded,
                    size: 200,
                    color: Color.fromARGB(255, 221, 221, 221),
                  ),
                  Text(provider.message),
                ],
              ),
            );

            /// Has Data State
          } else if (value.currentState == CurrentState.hasData) {
            return RestaurantListResult(
                restaurantsList: value.restaurantSearchList);

            /// Default State
          } else {
            return Center(
              child: Column(
                children: const [
                  Icon(
                    Icons.fastfood,
                    size: 200,
                    color: Color.fromARGB(255, 221, 221, 221),
                  ),
                  Text("Search Something"),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
