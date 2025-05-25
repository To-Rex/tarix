import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextSmall extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int maxLines;
  final double? fontSize;
  final double? letterSpacing;

  const TextSmall({super.key, required this.text, this.color = Colors.black, this.fontWeight = FontWeight.normal, this.textAlign = TextAlign.start, this.overflow = TextOverflow.ellipsis, this.maxLines = 1, this.fontSize, this.letterSpacing});

  @override
  Widget build(BuildContext context) => Text(text.tr, style: TextStyle(letterSpacing: letterSpacing ?? 0.3, fontFamily: 'Schyler', color: color, fontSize: fontSize ?? Theme.of(context).textTheme.bodyLarge!.fontSize, fontWeight: fontWeight), textAlign: textAlign, overflow: overflow, maxLines: maxLines);
}