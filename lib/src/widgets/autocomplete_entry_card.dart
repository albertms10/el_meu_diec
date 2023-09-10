import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/model/bookmark_collection.dart';
import 'package:el_meu_diec/src/theme.dart';
import 'package:el_meu_diec/src/widgets/definition_entry_sense_line.dart';
import 'package:el_meu_diec/src/widgets/equipped_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AutocompleteEntryCard extends StatelessWidget {
  final String id;
  final String query;
  final String word;
  final List<DefinitionEntrySense>? senses;
  final bool isLoading;

  const AutocompleteEntryCard({
    super.key,
    required this.id,
    required this.query,
    required this.word,
    this.senses,
    this.isLoading = false,
  });

  bool get isIncomplete => word.length > query.length;

  String get highlightedText =>
      isIncomplete ? word.substring(0, query.length) : word;

  @override
  Widget build(BuildContext context) {
    return EquippedCard(
      maxHeight: 150,
      isLoading: isLoading,
      actions: [
        if (!isLoading) _BookmarkButton(id: id, word: word),
      ],
      title: Text.rich(
        TextSpan(
          text: highlightedText,
          style: playfairDisplayTextTheme,
          children: [
            if (isIncomplete)
              TextSpan(
                text: word.substring(query.length),
                style: TextStyle(
                  color: playfairDisplayTextTheme.color!.withOpacity(0.4),
                ),
              ),
          ],
        ),
      ),
      child: senses == null
          ? null
          : SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < senses!.length; i++)
                    DefinitionEntrySenseLine(
                      sense: senses![i],
                      interactive: false,
                      isFirstNumber:
                          i == 0 || senses![i - 1].number != senses![i].number,
                    ),
                ],
              ),
            ),
    );
  }
}

class _BookmarkButton extends StatelessWidget {
  final String id;
  final String word;

  const _BookmarkButton({super.key, required this.id, required this.word});

  void _onPressed(BuildContext context) {
    final bookmarked = Provider.of<BookmarkCollection>(context, listen: false)
        .toggleBookmark(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          bookmarked
              ? 'S’ha afegit $word als marcadors.'
              : 'S’ha eliminat $word dels marcadors.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Theme.of(context).colorScheme.primary,
      icon: Icon(
        Provider.of<BookmarkCollection>(context).isBookmarked(id)
            ? Icons.bookmark
            : Icons.bookmark_outline,
      ),
      onPressed: () => _onPressed(context),
    );
  }
}
