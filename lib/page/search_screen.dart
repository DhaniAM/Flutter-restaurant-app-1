import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_1/data/api/api_service.dart';
import 'package:restaurant_app_1/data/provider/search_provider.dart';
import 'package:restaurant_app_1/widget/restaurants_list_builder.dart';
import 'package:restaurant_app_1/widget/state_message.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = "/searchScreen";
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchProvider(apiService: ApiService()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(255, 106, 106, 1),

          /// Input Text
          title: Consumer<SearchProvider>(
            builder: (context, SearchProvider data, child) {
              /// Search input
              return TextField(
                controller: data.controller,
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
                /// [controller] also get called, showing the search button
                onChanged: (value) {
                  data.setSearchState(true);
                },
                onSubmitted: (value) {
                  /// hiding the search button when user press Enter or
                  /// clicking Search button
                  data.setSearchState(false);
                  if (value != "") {
                    /// get search result
                    data.getSearchResult(data.controller.text);
                  }
                },
              );
            },
          ),

          /// Search Button
          actions: <Widget>[
            /// if not in [searchState], hide search button or if input is empty
            Consumer<SearchProvider>(
              builder: (context, SearchProvider data, child) {
                return (data.searchState == false || data.controller.text.isEmpty)
                    ? const SizedBox()
                    : IconButton(
                        icon: const Icon(Icons.search_rounded),
                        onPressed: () {
                          /// Hide search button
                          data.setSearchState(false);

                          /// Close keyboard
                          FocusManager.instance.primaryFocus?.unfocus();

                          /// get Data
                          if (data.controller.text != "") {
                            data.getSearchResult(data.controller.text);
                          }
                        },
                      );
              },
            ),
          ],
        ),

        /// Search Result
        body: Consumer<SearchProvider>(
          builder: (context, SearchProvider data, child) {
            /// Init state
            if (data.currentState == SearchCurrentState.loading) {
              return const Center(
                child: CircularProgressIndicator(color: Color.fromRGBO(255, 106, 106, 1)),
              );

              /// No Data State
            } else if (data.currentState == SearchCurrentState.noData) {
              return StateMessage(icon: Icons.fastfood, text: data.message);

              /// Error Data State
            } else if (data.currentState == SearchCurrentState.error) {
              return StateMessage(icon: Icons.cancel_rounded, text: data.message);

              /// Has Data State
            } else if (data.currentState == SearchCurrentState.hasData) {
              return RestaurantsListBuilder(restaurantsList: data.restaurantsList);

              /// Default State
            } else {
              return StateMessage(icon: Icons.fastfood, text: data.message);
            }
          },
        ),
      ),
    );
  }
}
