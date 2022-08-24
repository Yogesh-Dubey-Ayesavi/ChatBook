part of '../../../chatbook.dart';

class MessageBuilder extends StatefulWidget {
  const MessageBuilder({Key? key, required this.message, this.prevMessage})
      : super(key: key);
  final Message message;
  final Message? prevMessage;
  @override
  State<MessageBuilder> createState() => _MessageBuilderState();
}

class _MessageBuilderState extends State<MessageBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _dateProvider(widget.message, widget.prevMessage),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Container(
            width: double.infinity,
            alignment:
                widget.message.self != null && widget.message.self == true
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LimitedBox(
                  maxWidth: 6.5 / 10 * (MediaQuery.of(context).size.width),
                  child: IntrinsicWidth(
                    child: Bubble(
                      padding: const BubbleEdges.all(0),
                      showNip: _nipGiver(widget.message, widget.prevMessage),
                      nip: widget.message.self == true
                          ? BubbleNip.rightTop
                          : BubbleNip.leftTop,
                      color: _bubbleColorGiver(widget.message),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _messageProvider(widget.message)!,
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                      DateFormat.jm().format(
                                          DateTime.fromMicrosecondsSinceEpoch(
                                              widget.message.createdAt!)),
                                      style: widget.message.self == true
                                          ? InheritedChatTheme.of(context)
                                              .theme
                                              .sentTimeTextStyle
                                          : InheritedChatTheme.of(context)
                                              .theme
                                              .receivedTimeTextStyle),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  if (widget.message.self == true)
                                    _statusProvider(widget.message),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget? _messageProvider(Message message) {
    MessageType type = message.type;
    switch (type) {
      case MessageType.text:
        return TextMessageWidget(
          message: message as TextMessage,
        );
      case MessageType.gif:
        return GifMessageWidget(message: message as GifMessage);
      case MessageType.audio:
        message as AudioMessage;
        return AudioMessageWidget(message: message);
      default:
        return null;
    }
  }

  bool? _nipGiver(Message currentMessage, Message? prevMessage) {
    if (prevMessage != null &&
        sameDay(currentMessage.createdAt!, prevMessage.createdAt) == true &&
        currentMessage.self == prevMessage.self) {
      return false;
    } else {
      return true;
    }
  }

  Widget _dateProvider(Message currentMessage, Message? prevMessage) {
    if (prevMessage != null &&
        sameDay(currentMessage.createdAt!, prevMessage.createdAt) == false) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Text(
          DateFormat('dd MMM yyyy').format(
              DateTime.fromMicrosecondsSinceEpoch(currentMessage.createdAt!)),
          style: InheritedChatTheme.of(context).theme.dateHeaderTextStyle,
        ),
      );
    } else if (prevMessage == null) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          DateFormat('dd MMM yyyy').format(
              DateTime.fromMicrosecondsSinceEpoch(currentMessage.createdAt!)),
          style: InheritedChatTheme.of(context).theme.dateHeaderTextStyle,
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _statusProvider(Message message) {
    switch (message.status) {
      case Status.seen:
        return SvgPicture.asset(
          'assets/double_tick.svg',
          color: Colors.blue,
          height: 10,
          width: 10,
        );
      case Status.delivered:
        return SvgPicture.asset(
          'assets/double_tick.svg',
          color: Colors.grey,
          height: 10,
          width: 10,
        );
      case Status.error:
        return const Icon(Icons.error_outline, color: Colors.red, size: 18);
      case Status.sending:
        return const SizedBox(
            height: 10, width: 10, child: CupertinoActivityIndicator());
      case Status.sent:
        return SvgPicture.asset(
          'asset/single_tick.svg',
          color: Colors.grey,
          height: 10,
          width: 10,
        );
      default:
        return const SizedBox();
    }
  }

  Color _bubbleColorGiver(Message message) {
    if (["text", 'audio', 'video'].contains(message.type.name)) {
      return widget.message.self == true
          ? InheritedChatTheme.of(context).theme.sentMessageBubbleColor
          : InheritedChatTheme.of(context).theme.receivedMessageBubbleColor;
    } else if (message.type.name == 'gif') {
      return Colors.transparent;
    } else {
      return Colors.transparent;
    }
  }
}
