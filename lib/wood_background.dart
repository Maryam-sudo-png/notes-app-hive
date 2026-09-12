import 'package:flutter/material.dart';

class WoodBackground extends StatelessWidget {
  final Widget child;
  const WoodBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFC9986B), Color(0xFFA97C50), Color(0xFF8B5E34)],
        ),
      ),
      child: child,
    );
  }
}