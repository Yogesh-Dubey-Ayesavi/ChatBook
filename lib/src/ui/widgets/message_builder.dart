part of '../../../chatbook.dart';

class MessageBuilder extends StatefulWidget {
  const MessageBuilder({Key? key, required this.message, this.prevMessage})
      : super(key: key);
  final ValueNotifier<Message> message;
  final ValueNotifier<Message>? prevMessage;
  @override
  State<MessageBuilder> createState() => _MessageBuilderState();
}

class _MessageBuilderState extends State<MessageBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateProvider(
            message: widget.message.value,
            prevMessage: widget.prevMessage?.value),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Container(
            width: double.infinity,
            alignment: widget.message.value.self != null &&
                    widget.message.value.self == true
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LimitedBox(
                  maxWidth: 6.5 / 10 * (MediaQuery.of(context).size.width),
                  child: IntrinsicWidth(
                      child: RepaintBoundary(
                    child: Swipeable(
                      maxOffset: .7,
                      movementDuration: const Duration(milliseconds: 500),
                      background: const Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.share,
                            size: 20,
                            color: Colors.white,
                          )),
                      direction: SwipeDirection.startToEnd,
                      onSwipe: (dir) {
                        if (SwipeDirection.startToEnd == dir) {
                          logger.log("swiped");
                          InheritedProperties.of(context)
                              .tagHelper
                              .tagNotifier
                              .value = widget.message.value;
                        }
                      },
                      confirmSwipe: (direction) async {
                        logger.log((SwipeDirection.startToEnd == direction)
                            .toString());
                        return SwipeDirection.startToEnd == direction;
                      },
                      allowedPointerKinds: const {
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.stylus,
                        PointerDeviceKind.touch,
                        PointerDeviceKind.trackpad,
                        PointerDeviceKind.unknown,
                      },
                      key: const ValueKey(1),
                      child: Bubble(
                        padding: const BubbleEdges.all(0),
                        showNip: _nipGiver(
                            widget.message.value, widget.prevMessage?.value),
                        nip: widget.message.value.self == true
                            ? BubbleNip.rightTop
                            : BubbleNip.leftTop,
                        color: _bubbleColorGiver(widget.message.value),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.message.value.repliedMessage !=
                                null) ...[
                              RepliedMessageWidget(
                                repliedMessage:
                                    widget.message.value.repliedMessage!,
                              )
                            ],
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child:
                                  _messageWidgetProvider(widget.message.value)!,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                        DateFormat.jm().format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                widget
                                                    .message.value.createdAt!)),
                                        style: widget.message.value.self == true
                                            ? InheritedProperties.of(context)
                                                .theme
                                                .sentTimeTextStyle
                                            : InheritedProperties.of(context)
                                                .theme
                                                .receivedTimeTextStyle),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    if (widget.message.value.self == true)
                                      StatusProviderWidget(
                                          message: widget.message.value),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget? _messageWidgetProvider(Message message) {
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
      case MessageType.image:
        return ImageMessageWidget(message: message as ImageMessage);
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

  Color _bubbleColorGiver(Message message) {
    if (["text", 'audio', 'video', 'image'].contains(message.type.name)) {
      return widget.message.value.self == true
          ? InheritedProperties.of(context).theme.sentMessageBubbleColor
          : InheritedProperties.of(context).theme.receivedMessageBubbleColor;
    } else if (message.type.name == 'gif') {
      return Colors.transparent;
    } else {
      return Colors.transparent;
    }
  }
}
