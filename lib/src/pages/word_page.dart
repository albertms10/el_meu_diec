import 'package:el_meu_diec/src/widgets/autocomplete_entry_card.dart';
import 'package:flutter/material.dart';

import '../model/word.dart';

class WordPage extends StatelessWidget {
  final Word word;

  const WordPage({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                word.word,
                style: theme.textTheme.displaySmall,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 24),
              DefinitionEntrySenses(word: word),
            ],
          ),
        ),
      ),
    );
  }
}
