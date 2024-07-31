import 'dart:collection';

import 'package:flutter/material.dart';

final class BookmarkCollections with ChangeNotifier {
  final Map<String, BookmarkCollection> _collections;

  /// Creates a new [BookmarkCollections] from [_collections].
  BookmarkCollections._(this._collections);

  BookmarkCollections.fromNames(List<String> names)
      : this._({
          for (final name in names)
            name: BookmarkCollection(name: name, color: Colors.blue, {}),
        });

  Map<String, BookmarkCollection> get collections =>
      Map.unmodifiable(_collections);

  Set<BookmarkCollection> get sortedCollections =>
      SplayTreeSet.of(_collections.values);

  bool addCollection(BookmarkCollection collection) {
    notifyListeners();

    if (_collections.containsKey(collection.name)) return false;

    _collections.addAll({collection.name: collection});

    return true;
  }

  /// Returns whether [wordId] is bookmarked.
  bool isBookmarked(String wordId) =>
      _collections.values.any((collection) => collection.isBookmarked(wordId));

  /// Adds [wordId] bookmark from the last updated collection and returns `true`
  /// as a result.
  BookmarkCollection addBookmark(String wordId) {
    notifyListeners();

    return _collections[sortedCollections.first.name]!..addBookmark(wordId);
  }

  /// Removes [wordId] bookmark from the last updated collection and returns
  /// `false` as a result.
  BookmarkCollection removeBookmark(String wordId) {
    notifyListeners();

    return _collections[sortedCollections.first.name]!..removeBookmark(wordId);
  }
}

/// A collection of bookmarks.
final class BookmarkCollection implements Comparable<BookmarkCollection> {
  final String name;
  final Color color;
  final Map<String, DateTime> _bookmarks;

  late DateTime lastModified;

  /// Creates a new [BookmarkCollection] from [name] and [_bookmarks].
  BookmarkCollection(this._bookmarks, {required this.name, required this.color})
      : lastModified = DateTime.now();

  Map<String, DateTime> get bookmarks => Map.unmodifiable(_bookmarks);

  Map<String, DateTime> get sortedBookmarks => Map.unmodifiable(
        Map.fromEntries(
          _bookmarks.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value)),
        ),
      );

  /// Returns whether [wordId] is bookmarked.
  bool isBookmarked(String wordId) => _bookmarks.containsKey(wordId);

  /// Adds [wordId] bookmark and returns `true` as a result.
  bool addBookmark(String wordId) {
    lastModified = DateTime.now().toUtc();
    _bookmarks.addAll({wordId: lastModified});

    return true;
  }

  /// Removes [wordId] bookmark and returns `false` as a result.
  bool removeBookmark(String wordId) {
    lastModified = DateTime.now().toUtc();
    _bookmarks.remove(wordId);

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
