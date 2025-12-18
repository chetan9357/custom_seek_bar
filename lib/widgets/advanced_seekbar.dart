import 'package:flutter/material.dart';
import 'package:custom_seek_bar/widgets/gradient_slider_track_shape.dart';
import 'package:custom_seek_bar/widgets/icon_slider_thumb_shape.dart';
import 'package:custom_seek_bar/widgets/tick_marks_track_shape.dart';

enum SeekBarOrientation { horizontal, vertical }

class AdvancedSeekBar extends StatefulWidget {
  final double min;
  final double max;
  final double value;

  final IconData? thumbIcon;
  final String? thumbText;
  final double thumbSize;
  final Color thumbColor;

  final ValueChanged<double> onChanged;
  final List<String>? bubbleEmojis;

  final Color activeColor;
  final Color inactiveColor;
  final Gradient? gradient;

  final bool showBubble;
  final SeekBarOrientation orientation;
  final double height;

  // ✅ NEW
  final int? divisions;
  final Color? divisionColor;

  const AdvancedSeekBar({
    super.key,
    this.min = 0,
    this.max = 100,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.gradient,
    this.showBubble = true,
    this.orientation = SeekBarOrientation.horizontal,
    this.height = 6,
    this.thumbIcon,
    this.thumbSize = 20,
    this.thumbText,
    this.thumbColor = Colors.blue,
    this.bubbleEmojis,
    this.divisions,
    this.divisionColor, // 👈 tick steps
  });

  @override
  State<AdvancedSeekBar> createState() => _AdvancedSeekBarState();
}

class _AdvancedSeekBarState extends State<AdvancedSeekBar> {
  late double _value;
  bool _isDragging = false;

  static const double _bubbleHeight = 28;
  static const double _sliderLengthVertical = 200;
  static const double _thumbRadius = 10;
  static const double _bubbleGap = -1;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  double get _percent => (_value - widget.min) / (widget.max - widget.min);

  String _getBubbleEmoji() {
    if (widget.bubbleEmojis == null || widget.bubbleEmojis!.isEmpty) {
      return _value.toStringAsFixed(0);
    }

    final emojis = widget.bubbleEmojis!;
    final index = (_percent * (emojis.length - 1)).round();

    return emojis[index.clamp(0, emojis.length - 1)];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double verticalY =
            (_sliderLengthVertical - _thumbRadius * 2) * (1 - _percent) +
            _thumbRadius;

        verticalY = verticalY.clamp(
          _bubbleHeight / 2,
          _sliderLengthVertical - _bubbleHeight,
        );

        final Offset bubbleOffset =
            widget.orientation == SeekBarOrientation.horizontal
            ? Offset(
                _percent * constraints.maxWidth,
                -_bubbleHeight - _bubbleGap,
              )
            : Offset(
                -(_thumbRadius * -12 + _bubbleGap),
                verticalY - (_bubbleHeight / 2),
              );

        // 🔹 Base track (gradient or normal)
        final SliderTrackShape baseTrack = widget.gradient != null
            ? GradientSliderTrackShape(widget.gradient!)
            : const RoundedRectSliderTrackShape();

        final slider = SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: widget.height,
            inactiveTrackColor: widget.inactiveColor,
            overlayColor: widget.activeColor.withOpacity(0.2),

            thumbShape: (widget.thumbIcon != null || widget.thumbText != null)
                ? IconSliderThumbShape(
                    icon: widget.thumbIcon,
                    text: widget.thumbText,
                    size: widget.thumbSize,
                    color: widget.thumbColor,
                  )
                : const RoundSliderThumbShape(enabledThumbRadius: _thumbRadius),

            thumbColor: widget.thumbColor,

            trackShape: widget.divisions != null
                ? TickMarksTrackShape(
                    baseTrackShape: baseTrack,
                    divisions: widget.divisions!,
                    tickColor: widget.divisionColor ?? widget.inactiveColor,
                    // tickHeight: widget.height,
                    inactiveTickColor: widget.activeColor,
                  )
                : baseTrack,

            activeTrackColor: widget.gradient == null
                ? widget.activeColor
                : null,
          ),
          child: Slider(
            min: widget.min,
            max: widget.max,
            divisions: widget.divisions,
            // ✅ discrete
            value: _value,
            onChangeStart: (_) => setState(() => _isDragging = true),
            onChangeEnd: (_) => setState(() => _isDragging = false),
            onChanged: (val) {
              setState(() => _value = val);
              widget.onChanged(val);
            },
          ),
        );

        return SizedBox(
          height: widget.orientation == SeekBarOrientation.horizontal
              ? 50
              : _sliderLengthVertical,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (widget.showBubble && _isDragging)
                Positioned(
                  left: bubbleOffset.dx,
                  top: bubbleOffset.dy,
                  child: widget.bubbleEmojis != null
                      ? Text(
                          _getBubbleEmoji(),
                          style: const TextStyle(fontSize: 28),
                        )
                      : Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(12),
                          color: widget.activeColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: Text(
                              _value.toStringAsFixed(0),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ),

              widget.orientation == SeekBarOrientation.horizontal
                  ? slider
                  : RotatedBox(quarterTurns: -1, child: slider),
            ],
          ),
        );
      },
    );
  }
}
