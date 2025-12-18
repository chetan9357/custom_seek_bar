import 'package:flutter/material.dart';

class RangeSeekBar extends StatefulWidget {
  final double min;
  final double max;
  final RangeValues values;
  final ValueChanged<RangeValues> onChanged;

  final Color activeColor;
  final Color inactiveColor;
  final bool showBubble;

  const RangeSeekBar({
    super.key,
    this.min = 0,
    this.max = 100,
    required this.values,
    required this.onChanged,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey,
    this.showBubble = true,
  });

  @override
  State<RangeSeekBar> createState() => _RangeSeekBarState();
}

class _RangeSeekBarState extends State<RangeSeekBar> {
  late RangeValues _values;
  bool _isDragging = false;

  static const double _bubbleHeight = 28;
  static const double _bubbleGap = 6;

  @override
  void initState() {
    super.initState();
    _values = widget.values;
  }

  double _percent(double value) =>
      (value - widget.min) / (widget.max - widget.min);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final startX =
            _percent(_values.start) * constraints.maxWidth;
        final endX =
            _percent(_values.end) * constraints.maxWidth;

        return SizedBox(
          height: 60,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              /// 🔵 Start bubble
              if (widget.showBubble && _isDragging)
                Positioned(
                  left: startX - 16,
                  top: -_bubbleHeight - _bubbleGap,
                  child: _Bubble(
                    value: _values.start,
                    color: widget.activeColor,
                  ),
                ),

              /// 🔵 End bubble
              if (widget.showBubble && _isDragging)
                Positioned(
                  left: endX - 16,
                  top: -_bubbleHeight - _bubbleGap,
                  child: _Bubble(
                    value: _values.end,
                    color: widget.activeColor,
                  ),
                ),

              /// 🎚 Range Slider
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 6,
                  thumbColor: widget.activeColor,
                  activeTrackColor: widget.activeColor,
                  inactiveTrackColor: widget.inactiveColor,
                  rangeThumbShape:
                  const RoundRangeSliderThumbShape(
                    enabledThumbRadius: 10,
                  ),
                  overlayColor:
                  widget.activeColor.withOpacity(0.2),
                ),
                child: RangeSlider(
                  min: widget.min,
                  max: widget.max,
                  values: _values,
                  onChangeStart: (_) =>
                      setState(() => _isDragging = true),
                  onChangeEnd: (_) =>
                      setState(() => _isDragging = false),
                  onChanged: (val) {
                    setState(() => _values = val);
                    widget.onChanged(val);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// 🔵 Bubble widget (same style as single seekbar)
class _Bubble extends StatelessWidget {
  final double value;
  final Color color;

  const _Bubble({
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(12),
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Text(
          value.toStringAsFixed(0),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
