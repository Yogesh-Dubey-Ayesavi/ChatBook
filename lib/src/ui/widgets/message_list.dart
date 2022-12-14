part of '../../../chatbook.dart';

class MessageList extends StatefulWidget {
  const MessageList(
      {Key? key, required this.controller, required this.positionsListener})
      : super(key: key);

  final ItemScrollController controller;
  final ItemPositionsListener positionsListener;

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      reverse: true,
      itemScrollController: widget.controller,
      itemPositionsListener: widget.positionsListener,
      initialScrollIndex: 0,
      itemCount: InheritedMessagesWidget.of(context).messages.length,
      itemBuilder: (_, index) {
        return MessageBuilder(
          message: InheritedMessagesWidget.of(context).messages[index],
          prevMessage:
              index != InheritedMessagesWidget.of(context).messages.length - 1
                  ? InheritedMessagesWidget.of(context).messages[index + 1]
                  : null,
        );
      },
      scrollDirection: Axis.vertical,
    );
  }
}
