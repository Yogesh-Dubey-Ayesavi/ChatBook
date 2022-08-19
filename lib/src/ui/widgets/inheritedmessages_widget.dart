part of '../../../chatbook.dart';


class InheritedMessagesWidget extends InheritedWidget {
  const InheritedMessagesWidget({
    Key? key,
    required Widget child,
    required this.messages
  }) : super(key: key, child: child);

  final List<Message> messages ;

  static InheritedMessagesWidget of(BuildContext context) {
    final InheritedMessagesWidget? result = context.dependOnInheritedWidgetOfExactType<InheritedMessagesWidget>();
    assert(result != null, 'No InheritedMessagesWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedMessagesWidget old) {
    return old.messages != messages ;
  }
}
