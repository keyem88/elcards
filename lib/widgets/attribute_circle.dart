import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp/models/Card/playing_card.dart';
import 'package:myapp/widgets/cards/attribute_text.dart';

class AttributeCircle extends StatelessWidget {
  final double size;
  final List<Color> segmentColors;
  final PlayingCard card;

  const AttributeCircle(
      {Key? key,
      required this.size,
      required this.segmentColors,
      required this.card})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radius = size / 2;
    final textRadius = radius * 0.6; // Platzierungstiefe des Textes im Segment
    final textOffset = size * 0.12; // Dynamische Anpassung für Zentrierung

    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(size, size),
          painter: CircleSegmentPainter(segmentColors: segmentColors),
        ),
        // Positioniere den Text in der Mitte jedes Segments
        for (int i = 0; i < 3; i++)
          Positioned(
            left:
                radius + textRadius * cos(i * 2 * pi / 3 + pi / 3) - textOffset,
            top:
                radius + textRadius * sin(i * 2 * pi / 3 + pi / 3) - textOffset,
            child: i == 0
                ? AttribtueText(
                    icon: Icons.arrow_forward,
                    text: '${card.attack}',
                    withDots: false,
                  )
                : i == 1
                    ? AttribtueText(
                        icon: Icons.arrow_back,
                        text: '${card.defense}',
                        withDots: false,
                      )
                    : AttribtueText(
                        icon: Icons.speed,
                        text: '${card.speed}',
                        withDots: false,
                      ),
          ),
        /* CircleAvatar(
          backgroundColor: card.cardLevel.asColor,
          child: Text("${card.valency}"),
        ) */
      ],
    );
  }
}

class CircleSegmentPainter extends CustomPainter {
  final List<Color> segmentColors;

  CircleSegmentPainter({required this.segmentColors});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 5.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    // Zeichnen der Segmente
    for (int i = 0; i < 3; i++) {
      paint.color = segmentColors[i];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * (2 * pi / 3), // Startwinkel für jedes Segment
        2 * pi / 3, // Winkelumfang für jedes Segment
        true, // true, um einen Sektor zu füllen
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
