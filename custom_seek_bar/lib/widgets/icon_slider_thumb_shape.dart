import 'package:flutter/material.dart';

class IconSliderThumbShape extends SliderComponentShape {
  final IconData? icon;
  final String? text;
  final double size;
  final Color color;

  const IconSliderThumbShape({
    this.icon,
    this.text,
    this.size = 20,
    required this.color,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    // Thumb ka actual size = icon size
    return Size(size, size);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    // 🔥 ONLY ICON / EMOJI (NO CIRCLE, NO BACKGROUND)
    final TextPainter tp = TextPainter(
      textDirection: textDirection,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text ??
            (icon != null
                ? String.fromCharCode(icon!.codePoint)
                : ''),
        style: TextStyle(
          fontSize: size,
          fontFamily: icon?.fontFamily,
          package: icon?.fontPackage,
          color: color,
        ),
      ),
    );

    tp.layout();
    tp.paint(
      canvas,
      Offset(
        center.dx - tp.width / 2,
        center.dy - tp.height / 2,
      ),
    );
  }
}
