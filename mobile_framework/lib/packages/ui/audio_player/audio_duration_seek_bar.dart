import 'dart:math';

import 'package:flutter/material.dart';

class AudioDurationSeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  /// The theme for the slider that is used to select the position.
  final SliderThemeData? playSliderThemeData;

  /// The theme for the slider that is used to show the buffered position.
  final SliderThemeData? bufferSliderThemeData;

  const AudioDurationSeekBar({
    super.key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.playSliderThemeData,
    this.bufferSliderThemeData,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  AudioDurationSeekBarState createState() => AudioDurationSeekBarState();
}

class AudioDurationSeekBarState extends State<AudioDurationSeekBar> {
  double? _dragValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
          data: (widget.bufferSliderThemeData ?? SliderTheme.of(context))
              .copyWith(thumbShape: HiddenThumbComponentShape()),
          child: ExcludeSemantics(
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: min(widget.bufferedPosition.inMilliseconds.toDouble(),
                  widget.duration.inMilliseconds.toDouble()),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd!(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        SliderTheme(
          data: widget.playSliderThemeData ?? SliderTheme.of(context),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(Duration(milliseconds: value.round()));
              }
            },
            onChangeEnd: (value) {
              if (widget.onChangeEnd != null) {
                widget.onChangeEnd!(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
      ],
    );
  }
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

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
  }) {}
}

class AudioDurationPositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  AudioDurationPositionData(
      this.position, this.bufferedPosition, this.duration);
}
