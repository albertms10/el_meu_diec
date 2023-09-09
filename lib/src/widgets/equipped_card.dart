import 'package:el_meu_diec/src/theme.dart';
import 'package:flutter/material.dart';

class EquippedCard extends StatelessWidget {
  final Widget? title;
  final bool isFavorite;
  final bool isLoading;
  final double maxHeight;
  final Widget? child;

  const EquippedCard({
    super.key,
    this.title,
    this.isFavorite = false,
    this.isLoading = false,
    this.maxHeight = double.infinity,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return _EquippedCardBody(
      maxHeight: maxHeight,
      children: [
        Row(
          children: [
            if (isLoading)
              const _Placeholder(width: 180, height: 20)
            else if (title != null)
              title!,
            const Spacer(),
            const SizedBox(width: 4),
            if (isFavorite)
              Icon(
                Icons.star_rounded,
                color: playfairDisplayTextTheme.color!.withOpacity(0.4),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (isLoading) ...[
          const _Placeholder(width: 120),
          const _Placeholder(),
        ],
        if (child != null) child!,
      ],
    );
  }
}

class _EquippedCardBody extends StatelessWidget {
  final double maxHeight;
  final List<Widget> children;

  const _EquippedCardBody({
    super.key,
    this.maxHeight = double.infinity,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                right: 12,
                left: 12,
              ),
              child: Wrap(
                clipBehavior: Clip.antiAlias,
                children: children,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            child: Container(
              height: 32,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00ffffff),
                    Colors.white,
                  ],
                  stops: [0, 0.75],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  final double width;
  final double height;

  const _Placeholder({super.key, this.width = 80, this.height = 10});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: width,
      height: height,
      margin: const EdgeInsetsDirectional.only(top: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.onBackground.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
