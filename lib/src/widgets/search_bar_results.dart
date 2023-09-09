import 'dart:async';

import 'package:el_meu_diec/src/theme.dart';
import 'package:el_meu_diec/src/widgets/autocomplete_entries_list_view.dart';
import 'package:flutter/material.dart';

class SearchBarResults extends StatefulWidget {
  const SearchBarResults({super.key});

  @override
  State<SearchBarResults> createState() => _SearchBarResultsState();
}

class _SearchBarResultsState extends State<SearchBarResults> {
  final ValueNotifier<String> _query = ValueNotifier<String>('');
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _query.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ValueListenableBuilder<String>(
            valueListenable: _query,
            builder: (context, value, child) {
              return AutocompleteEntriesListView(query: value);
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            decoration: const BoxDecoration(
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  spreadRadius: 1,
                  color: Color(0x10000000),
                ),
              ],
            ),
            child: TextFormField(
              autocorrect: false,
              style: const TextStyle(fontSize: 18, color: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Cerca',
                suffixIcon: Padding(
                  padding: EdgeInsetsDirectional.only(end: 8),
                  child: Icon(Icons.search, color: Colors.grey),
                ),
              ),
              onChanged: _onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
