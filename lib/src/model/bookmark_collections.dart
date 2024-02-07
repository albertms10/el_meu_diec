import 'dart:collection';

import 'package:flutter/material.dart';

final class BookmarkCollections with ChangeNotifier {
  final Map<String, BookmarkCollection> _collections;

  /// Creates a new [BookmarkCollections] from [_collections].
  BookmarkCollections(this._collections);

  Map<String, BookmarkCollection> get collections =>
      Map.unmodifiable(_collections);

  Set<BookmarkCollection> get sortedCollections =>
      SplayTreeSet.of(_collections.values);

  void addCollection(String name) {
    notifyListeners();

    _collections.addAll({name: BookmarkCollection(name, {})});
  }

  /// Returns whether [id] is bookmarked.
  bool isBookmarked(String id) =>
      _collections.values.any((collection) => collection.isBookmarked(id));

  /// Adds [id] bookmark from the last updated collection and returns `true`
  /// as a result.
  BookmarkCollection addBookmark(String id) {
    notifyListeners();

    return _collections[sortedCollections.first.name]!..addBookmark(id);
  }

  /// Removes [id] bookmark from the last updated collection and returns `false`
  /// as a result.
  BookmarkCollection removeBookmark(String id) {
    notifyListeners();

    return _collections[sortedCollections.first.name]!..removeBookmark(id);
  }
}

/// A collection of bookmarks.
final class BookmarkCollection implements Comparable<BookmarkCollection> {
  final String name;
  final Map<String, DateTime> _bookmarks;

  late DateTime lastModified;

  /// Creates a new [BookmarkCollection] from [name] and [_bookmarks].
  BookmarkCollection(this.name, this._bookmarks)
      : lastModified = DateTime.now();

  Map<String, DateTime> get bookmarks => Map.unmodifiable(_bookmarks);

  Map<String, DateTime> get sortedBookmarks => Map.unmodifiable(
        Map.fromEntries(
          _bookmarks.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value)),
        ),
      );

  /// Returns whether [id] is bookmarked.
  bool isBookmarked(String id) => _bookmarks.containsKey(id);

  /// Adds [id] bookmark and returns `true` as a result.
  bool addBookmark(String id) {
    lastModified = DateTime.now().toUtc();
    _bookmarks.addAll({id: lastModified});

    return true;
  }

  /// Removes [id] bookmark and returns `false` as a result.
  bool removeBookmark(String id) {
    lastModified = DateTime.now().toUtc();
    _bookmarks.remove(id);

    return false;
  }

  @override
  bool operator ==(Object other) =>
      other is BookmarkCollection && name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  int compareTo(BookmarkCollection other) =>
      other.lastModified.compareTo(lastModified);
}
