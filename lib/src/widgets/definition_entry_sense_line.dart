import 'dart:ui';

import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/theme.dart';
import 'package:el_meu_diec/src/widgets/scope_chip.dart';
import 'package:flutter/material.dart';

class DefinitionEntrySenseLine extends StatelessWidget {
  final DefinitionEntrySense sense;
  final bool isFirstNumber;
  final bool interactive;

  const DefinitionEntrySenseLine({
    super.key,
    required this.sense,
    this.isFirstNumber = true,
    this.interactive = true,
  });

  @override
  Widget build(BuildContext context) {
    final proportionalFiguresTextStyle = notoSerifTextTheme.copyWith(
      fontFeatures: const [FontFeature.proportionalFigures()],
    );

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          if (sense.number != null) ...[
            SizedBox(
              width: 12,
              child: isFirstNumber
                  ? Text(
                      '${sense.number}',
                      style: proportionalFiguresTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 4),
          ],
          if (sense.subNumber != null) ...[
            Text('${sense.subNumber}', style: proportionalFiguresTextStyle),
            const SizedBox(width: 4),
          ],
          Expanded(
            child: Text.rich(
              softWrap: true,
              TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  if (sense.gender != null)
                    TextSpan(
                      text: '${sense.gender} ',
                      style: notoSerifTextTheme.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  if (sense.locution != null)
                    TextSpan(
                      text: '${sense.locution} ',
                      style: notoSerifTextTheme.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  for (final scope in sense.scopes)
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 4),
                        child: ScopeChip(
                          scope: scope,
                          interactive: interactive,
                        ),
                      ),
                    ),
                  if (sense.definition != null)
                    TextSpan(
                      text: '${sense.definition}',
                      style: notoSerifTextTheme,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
