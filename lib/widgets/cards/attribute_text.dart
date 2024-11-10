import 'package:flutter/material.dart';

class AttribtueText extends StatelessWidget {
  const AttribtueText(
      {super.key,
      required this.icon,
      required this.text,
      this.withDots = true});

  final IconData icon;
  final String text;
  final bool withDots;

  @override
  Widget build(BuildContext context) {
    return withDots
        ? Text.rich(
            TextSpan(children: [
              WidgetSpan(
                child: Icon(icon),
              ),
              const TextSpan(text: ' ... '),
              TextSpan(text: text)
            ]),
            textAlign: TextAlign.start,
          )
        : Column(
            children: [
              Icon(icon),
              Text(text),
            ],
          );
  }
}
