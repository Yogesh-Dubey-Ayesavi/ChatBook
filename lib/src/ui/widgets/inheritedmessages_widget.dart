part of '../../../chatbook.dart';

class InheritedMessagesWidget extends InheritedWidget {
  /// It inherits access to message among all of its child widgets.
  /// Messages are required to get acess to previous message and current message see [MessageList]

  const InheritedMessagesWidget(
      {Key? key, required Widget child, required this.messages})
      : super(key: key, child: child);

  final List<MessageBuilder> messages;

  static InheritedMessagesWidget of(BuildContext context) {
    final InheritedMessagesWidget? result =
        context.dependOnInheritedWidgetOfExactType<InheritedMessagesWidget>();
    assert(result != null, 'No InheritedMessagesWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedMessagesWidget oldWidget) {
    return oldWidget.messages != messages;
  }
}
