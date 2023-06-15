import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AutocompleteEntryListTile extends StatelessWidget {
  final String query;
  final String word;
  final bool isFavorite;
  final int visits;

  const AutocompleteEntryListTile({
    super.key,
    required this.query,
    required this.word,
    this.isFavorite = false,
    this.visits = 0,
  });

  bool get isIncomplete => word.length > query.length;

  String get highlightedText =>
      isIncomplete ? word.substring(0, query.length) : word;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final playfairDisplayTextTheme =
        GoogleFonts.playfairDisplayTextTheme().headline5!.copyWith(
              color: theme.colorScheme.onPrimary,
              fontSize: 24,
            );

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 40),
      title: RichText(
        text: TextSpan(
          text: highlightedText,
          style: playfairDisplayTextTheme,
          children: [
            if (isIncomplete)
              TextSpan(
                text: word.substring(query.length),
                style: playfairDisplayTextTheme.copyWith(
                  color: playfairDisplayTextTheme.color!.withOpacity(0.6),
                ),
              ),
          ],
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (visits > 0) _AutocompleteEntryVisits(visits: visits),
          if (isFavorite)
            Icon(
              Icons.star_rounded,
              color: playfairDisplayTextTheme.color!.withOpacity(0.4),
            ),
        ],
      ),
      onTap: () {},
    );
  }
}

class _AutocompleteEntryVisits extends StatelessWidget {
  final int visits;

  const _AutocompleteEntryVisits({super.key, this.visits = 0});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onPrimary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$visits',
          style: TextStyle(color: color.withOpacity(0.6)),
        ),
        const SizedBox(width: 4),
        Icon(
          Icons.remove_red_eye_rounded,
          size: 18,
          color: color.withOpacity(0.45),
        ),
      ],
    );
  }
}
