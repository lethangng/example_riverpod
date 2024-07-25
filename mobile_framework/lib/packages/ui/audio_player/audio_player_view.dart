import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

class AudioPlayerView extends ConsumerStatefulWidget {
  final AppFile file;
  final Widget Function(Widget controlButton, Widget seekBar, Widget timeView)
      builder;
  final Widget playButtonWidget;
  final Widget pauseButtonWidget;
  final Widget loadingWidget;
  final Widget replayWidget;
  final TextStyle timeStyle;

  /// The theme for the slider that is used to select the position.
  final SliderThemeData? playSliderThemeData;

  /// The theme for the slider that is used to show the buffered position.
  final SliderThemeData? bufferSliderThemeData;

  @override
  ConsumerState createState() => _AudioPlayerViewState();

  const AudioPlayerView(
      {super.key,
      required this.file,
      required this.builder,
      required this.playButtonWidget,
      required this.pauseButtonWidget,
      required this.loadingWidget,
      required this.replayWidget,
      required this.timeStyle,
      this.bufferSliderThemeData,
      this.playSliderThemeData});
}

class _AudioPlayerViewState extends ConsumerState<AudioPlayerView> {
  late AppFile currentFile;
  Stream<AudioDurationPositionData>? positionDataStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentFile = widget.file;
  }

  @override
  void didUpdateWidget(covariant AudioPlayerView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (oldWidget.file.fullUrl != widget.file.fullUrl) {
      ref.invalidate(audioPlayerControllerProvider);
      currentFile = widget.file;
      positionDataStream = null;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final player = ref.watch(audioPlayerControllerProvider(currentFile));

    positionDataStream ??= Rx.combineLatest3<Duration, Duration, Duration?,
                AudioDurationPositionData>(
            player.positionStream,
            player.bufferedPositionStream,
            player.durationStream,
            (position, bufferedPosition, duration) => AudioDurationPositionData(
                position, bufferedPosition, duration ?? Duration.zero))
        .asBroadcastStream();

    final controlButtons = StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading) {
          return widget.loadingWidget;
        } else if (playing != true) {
          return widget.playButtonWidget.onTapWidget(() {
            player.play();
          });
        } else if (processingState != ProcessingState.completed) {
          return widget.pauseButtonWidget.onTapWidget(() {
            player.pause();
          });
        } else {
          return widget.replayWidget.onTapWidget(() {
            player.seek(0.seconds);
          });
        }
      },
    );

    var timeView = StreamBuilder<AudioDurationPositionData>(
      stream: positionDataStream,
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data == null) {
          return Text('00:00', style: widget.timeStyle);
        }

        Duration remaining = data.duration - data.position;

        return Text(
            RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                    .firstMatch("$remaining")
                    ?.group(1) ??
                '$remaining',
            style: widget.timeStyle);
      },
    );

    var seekBar = StreamBuilder<AudioDurationPositionData>(
      stream: positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return AudioDurationSeekBar(
          duration: positionData?.duration ?? Duration.zero,
          position: positionData?.position ?? Duration.zero,
          bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
          onChangeEnd: player.seek,
          bufferSliderThemeData: widget.bufferSliderThemeData,
          playSliderThemeData: widget.playSliderThemeData,
        );
      },
    );

    return widget.builder(controlButtons, seekBar, timeView);
  }
}
