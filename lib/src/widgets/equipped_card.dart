import 'package:el_meu_diec/src/theme.dart';
import 'package:flutter/material.dart';

class EquippedCard extends StatelessWidget {
  final Widget? title;
  final bool isFavorite;
  final int visits;
  final bool isLoading;
  final Widget? child;

  const EquippedCard({
    super.key,
    this.title,
    this.isFavorite = false,
    this.visits = 0,
    this.isLoading = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 12,
          right: 12,
          left: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (title != null)
                  title!
                else
                  const _Placeholder(width: 180, height: 20),
                const Spacer(),
                if (visits > 0) _AutocompleteEntryVisits(visits: visits),
                const SizedBox(width: 4),
                if (isFavorite)
                  Icon(
                    Icons.star_rounded,
                    color: playfairDisplayTextTheme.color!.withOpacity(0.4),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (isLoading) ...[
              const _Placeholder(width: 120),
              const _Placeholder(),
            ],
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}

class _AutocompleteEntryVisits extends StatelessWidget {
  final int visits;

  const _AutocompleteEntryVisits({super.key, this.visits = 0});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onBackground;

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

class _Placeholder extends StatelessWidget {
  final double width;
  final double height;

  const _Placeholder({super.key, this.width = 80, this.height = 10});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: width,
      height: height,
      margin: const EdgeInsetsDirectional.only(top: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.onBackground.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
