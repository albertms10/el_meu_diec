import 'package:el_meu_diec/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class BookmarkButton extends StatelessWidget {
  final Word word;
  final bool isTonalFilled;

  const BookmarkButton({
    super.key,
    required this.word,
    this.isTonalFilled = false,
  });

  void _onPressed(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    final bookmarkCollections =
        Provider.of<BookmarkCollections>(context, listen: false);

    if (bookmarkCollections.isBookmarked(word.id)) return;

    final collection = bookmarkCollections.addBookmark(word.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: appLocalizations.added),
              const TextSpan(text: ' '),
              TextSpan(
                text: word.word,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: ' '),
              TextSpan(text: appLocalizations.toTheCollection),
              TextSpan(
                text: ' ${collection.name}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isBookmarked =
        Provider.of<BookmarkCollections>(context).isBookmarked(word.id);

    return (isTonalFilled ? IconButton.filledTonal : IconButton.new)(
      color: theme.colorScheme.primary,
      icon: Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
      ),
      enableFeedback: true,
      tooltip: isBookmarked
          ? appLocalizations.changeCollections
          : appLocalizations.addToACollection,
      onPressed: () => _onPressed(context),
    );
  }
}
