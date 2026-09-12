import 'package:flutter/material.dart';

class PaperCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const PaperCard({super.key, required this.child, this.padding = const EdgeInsets.all(16)});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF7),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 12, offset: const Offset(0, 6)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: CustomPaint(
          painter: _RuledPaperPainter(),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

class _RuledPaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.blue.withOpacity(0.15)
      ..strokeWidth = 1;
    for (double y = 32; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
    final marginPaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..strokeWidth = 1.5;
    canvas.drawLine(const Offset(28, 0), Offset(28, size.height), marginPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}