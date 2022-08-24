part of '../../chatbook.dart';

class AudioHelper {
  final progressNotifier = ProgressNotifier();
  // final repeatButtonNotifier = RepeatButtonNotifier();
  final playButtonNotifier = PlayButtonNotifier();

  late AudioPlayer _audioPlayer;
  // final _audioHandler = getIt<AudioHandler>();

  // Events: Calls coming from the UI
  void init(url) async {
    _audioPlayer = AudioPlayer();
    print(url);
    await _audioPlayer
        .setAudioSource(AudioSource.uri(Uri.parse(url)))
        .then((value) => print("audio:$value"));
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });

    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });

    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });

    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        // completed
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });
  }

  // await _loadPlaylist();
  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }
}
