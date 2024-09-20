import 'package:flutter/material.dart';

class AttribtueText extends StatelessWidget {
  const AttribtueText({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        WidgetSpan(
          child: Icon(icon),
        ),
        const TextSpan(text: ' ... '),
        TextSpan(text: text)
      ]),
      textAlign: TextAlign.start,
    );
  }
}
