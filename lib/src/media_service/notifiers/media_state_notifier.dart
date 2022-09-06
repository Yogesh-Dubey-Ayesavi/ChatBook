import 'package:flutter/foundation.dart';

class MediaStateNotifier extends ValueNotifier<MediaState> {
  MediaStateNotifier() : super(_initialValue);

  static const _initialValue = MediaState.uploading;
}

enum MediaState {
  uploading,
  downloading,
  uploadingCompleted,
  downloadingCompleted,
}
