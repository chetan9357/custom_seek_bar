import 'package:flutter/material.dart';

class RoundedSeekBar extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final double height;

  /// Custom Radius
  final double trackRadius;
  final double thumbRadius;

  /// 🔥 OPTIONAL bubble
  final bool showValueBubble;

  final Gradient? gradient;
  final Color inactiveColor;

  const RoundedSeekBar({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 100,
    this.height = 8,

    this.trackRadius = 50,
    this.thumbRadius = 10,

    /// 🔥 Default OFF
    this.showValueBubble = false,

    this.gradient,
    this.inactiveColor = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: height,
        trackShape: const RoundedRectSliderTrackShape(),

        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: thumbRadius,
        ),

        inactiveTrackColor: inactiveColor,
        activeTrackColor: Colors.transparent,

        /// 🔥 Bubble control
        showValueIndicator: showValueBubble
            ? ShowValueIndicator.always
            : ShowValueIndicator.never,

        valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),

        overlayShape: SliderComponentShape.noOverlay,
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          /// Inactive Track
          Container(
            height: height,
            decoration: BoxDecoration(
              color: inactiveColor,
              borderRadius: BorderRadius.circular(trackRadius),
            ),
          ),

          /// Active Gradient Track
          FractionallySizedBox(
            widthFactor: (value - min) / (max - min),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                gradient: gradient ??
                    const LinearGradient(
                      colors: [Colors.blue, Colors.lightBlueAccent],
                    ),
                borderRadius: BorderRadius.circular(trackRadius),
              ),
            ),
          ),

          /// Slider
          Slider(
            value: value,
            min: min,
            max: max,
            label: showValueBubble ? value.toInt().toString() : null,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
