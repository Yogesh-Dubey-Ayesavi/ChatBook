part of '../../../chatbook.dart';

class TaggedMessageIndicator extends StatefulWidget {
  const TaggedMessageIndicator({Key? key, required this.message})
      : super(key: key);

  final Message message;

  @override
  State<TaggedMessageIndicator> createState() => _TaggedMessageIndicatorState();
}

class _TaggedMessageIndicatorState extends State<TaggedMessageIndicator> {
  Widget _tagTextWidget(BuildContext context, TextMessage message) {
    return Text(message.text,
        maxLines: 3,
        style: InheritedChatTheme.of(context).theme.tagMessageTextStyle);
  }

  Widget _tagGiphyWidget(GifMessage message) {
    return SizedBox(
      child: GiphyGifWidget(
        imageAlignment: Alignment.centerRight,
        gif: message.gif,
        borderRadius: BorderRadius.circular(6),
        giphyGetWrapper:
            InheritedGifMessageGetWrapper.of(context).giphyGetWrapper,
        showGiphyLabel: true,
      ),
    );
  }

  Widget _tagAudioWidget(TextMessage message) {
    return Text('Audio Message',
        style: InheritedChatTheme.of(context).theme.tagMessageTextStyle);
  }

  Widget? tagGiver(Message message) {
    switch (message.type) {
      case MessageType.custom:
        break;
      case MessageType.file:
        break;
      case MessageType.image:
        break;
      case MessageType.system:
        // TODO: Handle this case.
        break;
      case MessageType.text:
        return _tagTextWidget(context, message as TextMessage);
      case MessageType.unsupported:
        // TODO: Handle this case.
        break;
      case MessageType.audio:
        // TODO: Handle this case.
        break;
      case MessageType.video:
        // TODO: Handle this case.
        break;
      case MessageType.emoji:
        // TODO: Handle this case.
        break;
      case MessageType.gif:
        // TODO: Handle this case.
        break;
      case MessageType.location:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 50,
      decoration: BoxDecoration(
          color: InheritedChatTheme.of(context).theme.messageInputColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0))),
      margin: EdgeInsets.zero,
      child: tagGiver(widget.message),
    );
  }
}
