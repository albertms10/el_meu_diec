import 'dart:io';
import 'dart:ui';

import 'package:el_meu_diec/src/pages/collections_page.dart';
import 'package:el_meu_diec/src/widgets/search_bar_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'El meu DIEC',
          style: TextStyle(fontVariations: [FontVariation.weight(600)]),
        ),
        backgroundColor: theme.canvasColor,
        surfaceTintColor: theme.canvasColor,
        shadowColor: theme.canvasColor,
        actions: const [
          _CollectionsIconButton(),
        ],
      ),
      backgroundColor: theme.canvasColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              heightFactor: 4.5,
              child: SizedBox(
                height: 140,
                child: SvgPicture.asset(
                  'assets/images/el_meu_diec_logo_watermark.svg',
                ),
              ),
            ),
            const SearchBarResults(),
          ],
        ),
      ),
    );
  }
}

class _CollectionsIconButton extends StatelessWidget {
  const _CollectionsIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return IconButton(
      icon: const Icon(Icons.bookmark),
      tooltip: appLocalizations.myCollections,
      onPressed: () => (Platform.isIOS
          ? showCupertinoModalBottomSheet
          : showBarModalBottomSheet)<void>(
        context: context,
        builder: (context) {
          return const CollectionsPage();
        },
      ),
    );
  }
}
