import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

class AudioPlayerDemoPage extends StatefulWidget {
  const AudioPlayerDemoPage({super.key});

  @override
  State<AudioPlayerDemoPage> createState() => _AudioPlayerDemoPageState();
}

class _AudioPlayerDemoPageState extends State<AudioPlayerDemoPage> {
  AppFile file1 = AppFile.local(
      path: "https://samples-files.com/samples/Audio/wav/sample-file-4.wav",
      fileName: "sample-file-4.wav");

  AppFile file2 = AppFile.local(
      path: "https://samples-files.com/samples/Audio/wav/sample-file-3.wav",
      fileName: "sample-file-4.wav");

  late AppFile currentFile = file1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Audio Player Demo'),
        ),
        body: Column(
          children: [
            TextButton(
                onPressed: () {
                  setState(() {
                    currentFile = file1;
                  });
                },
                child: const Text("Play Audio 1")),
            TextButton(
                onPressed: () {
                  setState(() {
                    currentFile = file2;
                  });
                },
                child: const Text("Play Audio 2")),
            const Spacer(),
            AudioPlayerView(
              loadingWidget: const CircularProgressIndicator(),
              pauseButtonWidget: const Icon(Icons.pause),
              playButtonWidget: const Icon(Icons.play_arrow),
              replayWidget: const Icon(Icons.replay),
              timeStyle: const TextStyle(color: Colors.white),
              bufferSliderThemeData:
                  SliderThemeData(activeTrackColor: Colors.grey.shade300),
              playSliderThemeData: const SliderThemeData(
                  activeTrackColor: Colors.red, thumbColor: Colors.black),
              file: currentFile,
              builder: (controlButton, seekBar, time) {
                return Container(
                  height: 100,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.green),
                  child: Row(
                    children: [controlButton, seekBar.expand(), time],
                  ).center().defaultHorizontalPadding(),
                ).defaultHorizontalPadding();
              },
            )
                .align(Alignment.bottomCenter)
                .paddingOnly(bottom: context.includeBottomPadding(12)),
          ],
        ));
  }
}

T? ambiguate<T>(T? value) => value;
