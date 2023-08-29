import 'package:el_meu_diec/model.dart';
import 'package:flutter/material.dart';

class DefinitionEntrySenseLine extends StatelessWidget {
  final DefinitionEntrySense sense;

  const DefinitionEntrySenseLine({super.key, required this.sense});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: [
          if (sense.number != null)
            TextSpan(
              text: '${sense.number}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          if (sense.subNumber != null) TextSpan(text: '${sense.subNumber}'),
          if (sense.gender != null)
            TextSpan(
              text: '${sense.gender}',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          if (sense.locution != null)
            TextSpan(
              text: '${sense.locution}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          for (final scope in sense.scopes) TextSpan(text: '$scope'),
          if (sense.definition != null) TextSpan(text: '${sense.definition}'),
        ],
      ),
    );
  }
}
