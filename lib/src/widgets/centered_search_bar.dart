import 'package:el_meu_diec/src/widgets/autocomplete_entries_list_view.dart';
import 'package:flutter/material.dart';

class CenteredSearchBar extends StatefulWidget {
  const CenteredSearchBar({super.key});

  @override
  State<CenteredSearchBar> createState() => _CenteredSearchBarState();
}

class _CenteredSearchBarState extends State<CenteredSearchBar> {
  final ValueNotifier<String> _query = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 40),
          child: ValueListenableBuilder<String>(
            valueListenable: _query,
            builder: (context, value, child) {
              return AutocompleteEntriesListView(query: value);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Cerca',
              suffixIcon: Padding(
                padding: EdgeInsetsDirectional.only(end: 8),
                child: Icon(Icons.search),
              ),
            ),
            onChanged: (value) {
              _query.value = value;
            },
          ),
        ),
      ],
    );
  }
}