part of '../../../chatbook.dart';

class InheritedChatTheme extends InheritedWidget {
  /// It inherits one common theme among all its child widgets.

  const InheritedChatTheme({
    Key? key,
    required Widget child,
    required this.theme,
    // required this.messages,
    // required this.giphyGetWrapper,
  }) : super(key: key, child: child);

  final ChatTheme theme;
  // final GiphyGetWrapper giphyGetWrapper;
  // final List<Message> messages;
  static InheritedChatTheme of(BuildContext context) {
    final InheritedChatTheme? result =
        context.dependOnInheritedWidgetOfExactType<InheritedChatTheme>();
    assert(result != null, 'No InheritedChatTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedChatTheme old) {
    return old.theme != theme;
  }
}
