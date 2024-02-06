import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/pages/bookmark_collection_page.dart';
import 'package:el_meu_diec/src/pages/collections_page.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CollectionsNavigator extends StatelessWidget {
  const CollectionsNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: CollectionsPage.routeName,
      onGenerateRoute: (routeSettings) {
        return MaterialWithModalsPageRoute(
          settings: routeSettings,
          builder: (context) {
            switch (routeSettings.name) {
              case BookmarkCollectionPage.routeName:
                return BookmarkCollectionPage(
                  collection: routeSettings.arguments! as BookmarkCollection,
                );

              default:
                return const CollectionsPage();
            }
          },
        );
      },
    );
  }
}
