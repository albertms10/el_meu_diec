import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/theme.dart';
import 'package:el_meu_diec/src/widgets/scope_chip.dart';
import 'package:flutter/material.dart';

class DefinitionEntrySenseLine extends StatelessWidget {
  final DefinitionEntrySense sense;
  final bool isFirstNumber;
  final bool isInteractive;

  const DefinitionEntrySenseLine({
    super.key,
    required this.sense,
    this.isFirstNumber = true,
    this.isInteractive = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyTextTheme = theme.textTheme.bodyTextStyle;
    final proportionalFiguresTextStyle =
        theme.textTheme.proportionalFiguresTextStyle;

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
                children: [
                  if (sense.gender != null)
                    TextSpan(
                      text: '${sense.gender} ',
                      style: bodyTextTheme.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  if (sense.locution != null)
                    TextSpan(
                      text: '${sense.locution} ',
                      style: bodyTextTheme.copyWith(
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
                          isInteractive: isInteractive,
                        ),
                      ),
                    ),
                  if (sense.definition != null)
                    TextSpan(
                      text: '${sense.definition} ',
                      style: bodyTextTheme,
                    ),
                  if (sense.redirectWord != null)
                    TextSpan(
                      text: 'v. ${sense.redirectWord!.word}',
                      style:
                          bodyTextTheme.copyWith(fontWeight: FontWeight.bold),
                    ),
                  for (final example in sense.examples)
                    TextSpan(
                      text: '$example ',
                      style: bodyTextTheme.copyWith(
                        color: bodyTextTheme.color?.withOpacity(0.6),
                      ),
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
