part of '../../chatbook.dart';

class MediaStateHelper {
  final mediaStateNotifier = MediaStateNotifier();

  void changeState(MediaState newState) {
    mediaStateNotifier.value = newState;
  }

  
}
