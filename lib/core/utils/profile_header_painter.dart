import 'package:flutter/material.dart';
import 'package:oivan_assignment/core/constants/app_colors.dart';

class ProfileHeaderPainter extends CustomPainter {
  final Color? backGroundColor;
  final Color? borderColor;
  final double? borderWidth;

  ProfileHeaderPainter({
    this.backGroundColor,
    this.borderColor,
    this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(size.width * -0.001333333, 0);
    path.lineTo(size.width * -0.001333333, size.height);
    path.lineTo(size.width * 0.2319760, size.height);
    path.cubicTo(
        size.width * 0.2570728,
        size.height * 1.000240,
        size.width * 0.2817120,
        size.height * 0.9856171,
        size.width * 0.3031760,
        size.height * 0.9577486);
    path.cubicTo(
        size.width * 0.3246400,
        size.height * 0.9298800,
        size.width * 0.3420960,
        size.height * 0.8898457,
        size.width * 0.3536160,
        size.height * 0.8420686);
    path.cubicTo(
        size.width * 0.3672293,
        size.height * 0.7847029,
        size.width * 0.3879840,
        size.height * 0.7365314,
        size.width * 0.4135867,
        size.height * 0.7028857);
    path.cubicTo(
        size.width * 0.4391867,
        size.height * 0.6692343,
        size.width * 0.4686347,
        size.height * 0.6514229,
        size.width * 0.4986667,
        size.height * 0.6514229);
    path.cubicTo(
        size.width * 0.5286987,
        size.height * 0.6514229,
        size.width * 0.5581467,
        size.height * 0.6692343,
        size.width * 0.5837467,
        size.height * 0.7028857);
    path.cubicTo(
        size.width * 0.6093493,
        size.height * 0.7365314,
        size.width * 0.6301040,
        size.height * 0.7847029,
        size.width * 0.6437173,
        size.height * 0.8420686);
    path.cubicTo(
        size.width * 0.6552373,
        size.height * 0.8898457,
        size.width * 0.6726933,
        size.height * 0.9298800,
        size.width * 0.6941573,
        size.height * 0.9577486);
    path.cubicTo(
        size.width * 0.7156213,
        size.height * 0.9856171,
        size.width * 0.7402613,
        size.height * 1.000240,
        size.width * 0.7653573,
        size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * -0.001333333, 0);
    path.close();

    // Fill background
    Paint fillPaint = Paint()..style = PaintingStyle.fill;
    fillPaint.color = backGroundColor ?? AppColors.secondaryColor;
    canvas.drawPath(path, fillPaint);
    // Draw border only for the bottom curve
    Paint borderPaint = Paint()
      ..color = borderColor ?? Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth ?? 2.0;

    // path for border
    Path borderPath = Path();
    borderPath.moveTo(0, size.height);
    borderPath.cubicTo(
        size.width * 0.2570728,
        size.height * 1.000240,
        size.width * 0.2817120,
        size.height * 0.9856171,
        size.width * 0.3031760,
        size.height * 0.9577486);
    borderPath.cubicTo(
        size.width * 0.3246400,
        size.height * 0.9298800,
        size.width * 0.3420960,
        size.height * 0.8898457,
        size.width * 0.3536160,
        size.height * 0.8420686);
    borderPath.cubicTo(
        size.width * 0.3672293,
        size.height * 0.7847029,
        size.width * 0.3879840,
        size.height * 0.7365314,
        size.width * 0.4135867,
        size.height * 0.7028857);
    borderPath.cubicTo(
        size.width * 0.4391867,
        size.height * 0.6692343,
        size.width * 0.4686347,
        size.height * 0.6514229,
        size.width * 0.4986667,
        size.height * 0.6514229);
    borderPath.cubicTo(
        size.width * 0.5286987,
        size.height * 0.6514229,
        size.width * 0.5581467,
        size.height * 0.6692343,
        size.width * 0.5837467,
        size.height * 0.7028857);
    borderPath.cubicTo(
        size.width * 0.6093493,
        size.height * 0.7365314,
        size.width * 0.6301040,
        size.height * 0.7847029,
        size.width * 0.6437173,
        size.height * 0.8420686);
    borderPath.cubicTo(
        size.width * 0.6552373,
        size.height * 0.8898457,
        size.width * 0.6726933,
        size.height * 0.9298800,
        size.width * 0.6941573,
        size.height * 0.9577486);
    borderPath.cubicTo(
        size.width * 0.7156213,
        size.height * 0.9856171,
        size.width * 0.7402613,
        size.height * 1.000240,
        size.width * 0.7653573,
        size.height);
    borderPath.lineTo(size.width, size.height);
    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
