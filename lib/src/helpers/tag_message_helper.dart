part of '../../chatbook.dart';

class TagMessageHelper {
  final tagNotifier = ValueNotifier<Message?>(null);

  void createTag(
    Message message,
  ) {
    tagNotifier.value = message;
  }

  void disposeTag() {
    //! dispose your tag here
    tagNotifier.value = null;
  }
  
}
