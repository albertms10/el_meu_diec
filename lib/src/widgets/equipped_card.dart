import 'package:flutter/material.dart';

class EquippedCard extends StatelessWidget {
  final double? height;
  final bool isLoading;
  final VoidCallback? onTap;
  final List<Widget>? actions;
  final Widget? child;

  const EquippedCard({
    super.key,
    this.height,
    this.isLoading = false,
    this.onTap,
    this.actions,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return _EquippedCardBody(
      height: height,
      onTap: onTap,
      children: [
        const SizedBox(height: 12),
        if (isLoading)
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // To occupy the entire column width.
              SizedBox(width: double.infinity),
              _Placeholder(width: 180, height: 20),
              _Placeholder(width: 120),
              _Placeholder(),
            ],
          )
        else if (child != null)
          child!,
      ],
    );
  }
}

class _EquippedCardBody extends StatelessWidget {
  final double? height;
  final VoidCallback? onTap;
  final List<Widget> children;

  const _EquippedCardBody({
    super.key,
    this.height,
    this.onTap,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        onTap: onTap,
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Wrap(
            clipBehavior: Clip.antiAlias,
            children: children,
          ),
        ),
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
