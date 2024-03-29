import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/widgets/conditional_widget_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScopeChip extends StatelessWidget {
  final Scope scope;
  final bool isInteractive;

  const ScopeChip({super.key, required this.scope, this.isInteractive = true});

  void _onTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(scope.label),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      child: Material(
        color: Colors.grey[100],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          side: BorderSide(color: Color(0xFFE0E0E0)),
        ),
        child: ConditionalWidgetWrap(
          condition: isInteractive,
          conditionalBuilder: (child) {
            return Tooltip(
              message: appLocalizations.showAbbreviation,
              child: InkWell(
                onTap: () => _onTap(context),
                child: child,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 6,
              end: 6,
              top: 3,
              bottom: 4,
            ),
            child: Text(
              scope.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
