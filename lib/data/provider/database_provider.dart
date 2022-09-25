import 'package:flutter/foundation.dart';
import 'package:restaurant_app_1/data/db/database_helper.dart';
import 'package:restaurant_app_1/data/model/restaurants_model.dart';
import 'package:restaurant_app_1/data/state/current_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getBookmarks();
  }

  late DatabaseState _currentState;
  String _message = '';
  List<Restaurants> _bookmarks = [];

  DatabaseState get currentState => _currentState;
  String get message => _message;
  List<Restaurants> get bookmarks => _bookmarks;

  /// get bookmark
  void _getBookmarks() async {
    _bookmarks = await databaseHelper.getBookmarks();
    if (_bookmarks.isNotEmpty) {
      _currentState = DatabaseState.hasData;
    } else {
      _currentState = DatabaseState.noData;
      _message = 'No favorite';
    }
    notifyListeners();
  }

  /// is bookmarked
  Future<bool> isBookmarked(String id) async {
    final bookmarked = await databaseHelper.getBookmarkById(id);
    return bookmarked.isNotEmpty;
  }

  /// add bookmark
  void addBookmark(Restaurants restaurants) async {
    try {
      await databaseHelper.insertBookmark(restaurants);
      _getBookmarks();
    } catch (e) {
      _currentState = DatabaseState.error;
      _message = "Error, can't add favorite";
      notifyListeners();
    }
  }

  /// remove
  void removeBookmark(String id) async {
    try {
      await databaseHelper.removeBookmark(id);
      _getBookmarks();
    } catch (e) {
      _currentState = DatabaseState.error;
      _message = "Error, can't remove favorite";
      notifyListeners();
    }
  }
}
