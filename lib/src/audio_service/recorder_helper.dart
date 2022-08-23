part of '../../chatbook.dart';

class RecorderHelper {
  Timer? timer;
  late Record _audioRecorder;
  StreamSubscription<RecordState>? recordSub;
  final recordStateNotifier = ValueNotifier<RecordState>(RecordState.stop);
  final amplitudeNotifier =
      ValueNotifier<Amplitude>(Amplitude(current: 0, max: 0));
  final timerNotifier = ValueNotifier<int>(0);
  StreamSubscription<Amplitude>? amplitudeSub;

  void init() {
    _audioRecorder = Record();
    recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      recordStateNotifier.value = recordState;
    });

    amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) => {amplitudeNotifier.value = amp});
  }

  Future<void> startRecorder() async {
    try {
      timerNotifier.value = 0;

      if (await _audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (kDebugMode) {
          print('${AudioEncoder.aacLc.name} supported: $isSupported');
        }

        // final devs = await _audioRecorder.listInputDevices();
        // final isRecording = await _audioRecorder.isRecording();

        await _audioRecorder.start();
        startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<Map<String, dynamic>?> stop() async {
    timer?.cancel();

    final path = await _audioRecorder.stop();

    if (path != null) {
      return {"path": path, "duration": timerNotifier.value};
    }
    return null;
  }

  Future<void> pause() async {
    timer?.cancel();
    await _audioRecorder.pause();
  }

  Future<void> resume() async {
    startTimer();
    await _audioRecorder.resume();
  }

  void startTimer() {
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      timerNotifier.value++;
    });
  }

  Future<bool> isRecording() async {
    return await _audioRecorder.isRecording();
  }

  void dispose() {
    _audioRecorder.dispose();
  }
}
