import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

class AudioPlayerController
    extends AutoDisposeFamilyNotifier<AudioPlayer, AppFile> {
  @override
  AudioPlayer build(AppFile arg) {
    final audioPlayer = AudioPlayer();
    audioPlayer.setUrl(arg.fullUrl);
    return audioPlayer;
  }

  void stop() {
    state.stop();
    state.dispose();
  }
}

final audioPlayerControllerProvider = NotifierProvider.autoDispose
    .family<AudioPlayerController, AudioPlayer, AppFile>(
        () => AudioPlayerController());
