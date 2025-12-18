import 'package:flutter/material.dart';

class TickMarksTrackShape extends SliderTrackShape {
  final SliderTrackShape baseTrackShape;
  final int divisions;
  final Color tickColor;
  final double tickHeight;
  final Color inactiveTickColor;

  const TickMarksTrackShape({
    required this.baseTrackShape,
    required this.divisions,
    required this.inactiveTickColor,
    required this.tickColor,
    this.tickHeight = 6,
  });

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    return baseTrackShape.getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    Offset? secondaryOffset,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    // 1️⃣ draw base track (gradient / normal)
    baseTrackShape.paint(
      context,
      offset,
      parentBox: parentBox,
      secondaryOffset: secondaryOffset,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      textDirection: textDirection,
      thumbCenter: thumbCenter,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // 2️⃣ draw ticks
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
    );

    final Paint paint = Paint()
      ..color = tickColor
      ..strokeWidth = 1;

    final double step = trackRect.width / divisions;

    for (int i = 0; i <= divisions; i++) {
      final double dx = trackRect.left + step * i;

      final Paint paint = Paint()
        ..color = dx <= thumbCenter.dx
            ? tickColor // 🔵 active dot
            : inactiveTickColor // ⚪ inactive dot
        ..strokeWidth = 1;

      context.canvas.drawLine(
        Offset(dx, trackRect.center.dy - tickHeight / 2),
        Offset(dx, trackRect.center.dy + tickHeight / 2),
        paint,
      );
    }
  }
}
