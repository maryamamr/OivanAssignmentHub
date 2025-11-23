import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.responsiveFontSize,
    this.textScaler,
    this.fontWeight,
    this.size,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final double? size;
  final TextScaler? textScaler;

  final Map<double, double>? responsiveFontSize;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double? fontSize = style?.fontSize;

    if (responsiveFontSize != null) {
      final breakpoints = responsiveFontSize!.keys.toList()..sort();
      for (final breakpoint in breakpoints) {
        if (screenWidth >= breakpoint) {
          fontSize = responsiveFontSize![breakpoint];
        }
      }
    }

    return Text(
      text,
      style: style?.copyWith(fontSize: fontSize) ??
          TextStyle(fontSize: size ?? fontSize, fontWeight: fontWeight),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      textScaler: textScaler ?? MediaQuery.of(context).textScaler,
    );
  }
}
