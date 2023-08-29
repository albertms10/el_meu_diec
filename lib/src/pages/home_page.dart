import 'package:el_meu_diec/src/widgets/search_bar_results.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const SafeArea(
        child: SearchBarResults(),
      ),
    );
  }
}
