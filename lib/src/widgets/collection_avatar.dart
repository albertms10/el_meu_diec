import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/utils/string_extension.dart';
import 'package:flutter/material.dart';

class CollectionAvatar extends StatelessWidget {
  final List<Word?> words;

  const CollectionAvatar({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const wordTextStyle =
        TextStyle(fontSize: 16, letterSpacing: -0.5, height: 1.15);

    return Container(
      width: 72,
      height: 72,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Wrap(
        spacing: 2,
        runSpacing: 1,
        clipBehavior: Clip.antiAlias,
        children: [
          for (var i = 0; i < words.length; i++)
            Text(
              words[i]?.word.stripNumbers ?? '',
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
              style: wordTextStyle.copyWith(
                color: i.isOdd
                    ? theme.colorScheme.inversePrimary
                    : Colors.grey[600],
              ),
            ),
        ],
      ),
    );
  }
}
