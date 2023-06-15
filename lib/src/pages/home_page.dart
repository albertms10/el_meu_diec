import 'package:el_meu_diec/src/model/definition_entry_senses.dart';
import 'package:el_meu_diec/src/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    DefinitionEntrySenses.fetch('0043352');

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'DIEC 3',
                style: theme.textTheme.displayMedium!
                    .copyWith(color: colorScheme.onPrimary),
              ),
              const SizedBox(height: 40),
              const Expanded(child: SearchBar()),
            ],
          ),
        ),
      ),
    );
  }
}
