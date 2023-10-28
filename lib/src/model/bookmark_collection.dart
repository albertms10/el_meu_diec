import 'package:flutter/material.dart';

/// A collection of bookmarks.
class BookmarkCollection with ChangeNotifier {
  final Map<String, bool> _bookmarks;

  /// Creates a new [BookmarkCollection] from [_bookmarks].
  BookmarkCollection(this._bookmarks);

  Map<String, bool> get bookmarks => Map.unmodifiable(_bookmarks);

  /// Returns whether [id] is bookmarked.
  bool isBookmarked(String id) => _bookmarks[id] ?? false;

  /// Adds [id] bookmark and returns `true` as a result.
  bool addBookmark(String id) {
    _bookmarks.addAll({id: true});
    notifyListeners();

    return true;
  }

  /// Removes [id] bookmark and returns `false` as a result.
  bool removeBookmark(String id) {
    _bookmarks.remove(id);
    notifyListeners();

    return false;
  }

  /// Toggles [id] bookmark and returns the operation result.
  bool toggleBookmark(String id) =>
      isBookmarked(id) ? removeBookmark(id) : addBookmark(id);
}
