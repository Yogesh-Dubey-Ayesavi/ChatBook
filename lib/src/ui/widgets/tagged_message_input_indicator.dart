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
    return SizedBox(
      child: Text(message.text,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: InheritedProperties.of(context).theme.tagMessageTextStyle),
    );
  }

  Widget _tagGiphyWidget(BuildContext context, GifMessage message) {
    return SizedBox(
      child: GiphyGifWidget(
        gif: message.gif,
        borderRadius: BorderRadius.circular(6),
        giphyGetWrapper: InheritedProperties.of(context).giphyGetWrapper,
        showGiphyLabel: true,
      ),
    );
  }

  Widget _tagAudioWidget(BuildContext context, AudioMessage message) {
    return Text('Audio Message',
        style: InheritedProperties.of(context).theme.tagMessageTextStyle);
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
        return _tagAudioWidget(context, message as AudioMessage);

      case MessageType.video:
        // TODO: Handle this case.
        break;
      case MessageType.emoji:
        // TODO: Handle this case.
        break;
      case MessageType.gif:
        return _tagGiphyWidget(context, message as GifMessage);
      case MessageType.location:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: double.infinity,
      duration: const Duration(milliseconds: 1000),
      height: 50,
      decoration: BoxDecoration(
          color: InheritedProperties.of(context).theme.messageInputColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0))),
      margin: EdgeInsets.zero,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
            child: SizedBox(
          height: 80,
          child: Card(
              color: Colors.white30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: tagGiver(widget.message)!,
              )),
        )),
        IconButton(
          onPressed: () {
            InheritedProperties.of(context).tagHelper.disposeTag();
          },
          icon: Text(
            'X',
            style: InheritedProperties.of(context).theme.sentMessageTextStyle,
          ),
        )
      ]),
    );
  }
}
