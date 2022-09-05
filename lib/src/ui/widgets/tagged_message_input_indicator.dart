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

  Widget _tagImageWidget(BuildContext context, ImageMessage message) {
    return Text('Image Message',
        style: InheritedProperties.of(context).theme.tagMessageTextStyle);
  }

  Widget _tagCustomWidget(BuildContext context, CustomMessage message) {
    return Text('Custom Message',
        style: InheritedProperties.of(context).theme.tagMessageTextStyle);
  }

  Widget _tagFileWidget(BuildContext context, FileMessage message) {
    return Text('File Message',
        style: InheritedProperties.of(context).theme.tagMessageTextStyle);
  }

  Widget _tagSystemWidget(BuildContext context, SystemMessage message) {
    return Text('System Message',
        style: InheritedProperties.of(context).theme.tagMessageTextStyle);
  }

  Widget _tagVideoWidget(BuildContext context, VideoMessage message) {
    return Text('VideoMessage Message',
        style: InheritedProperties.of(context).theme.tagMessageTextStyle);
  }

  Widget _tagEmojiWidget(BuildContext context, EmojiMessage message) {
    return Text('EmojiMessage Message',
        style: InheritedProperties.of(context).theme.tagMessageTextStyle);
  }

  Widget _tagUnsupportedWidget(
      BuildContext context, UnsupportedMessage message) {
    return Text('UnsupportedMessage Message',
        style: InheritedProperties.of(context).theme.tagMessageTextStyle);
  }

  Widget _tagLocationWidget(BuildContext context, UnsupportedMessage message) {
    return Text('LocationMessage Message',
        style: InheritedProperties.of(context).theme.tagMessageTextStyle);
  }

  Widget? tagGiver(Message message) {
    switch (message.type) {
      case MessageType.custom:
        return _tagCustomWidget(context, message as CustomMessage);
      case MessageType.file:
        return _tagFileWidget(context, message as FileMessage);
      case MessageType.image:
        return _tagImageWidget(context, message as ImageMessage);
      case MessageType.system:
        return _tagSystemWidget(context, message as SystemMessage);
      case MessageType.text:
        return _tagTextWidget(context, message as TextMessage);
      case MessageType.unsupported:
        return _tagUnsupportedWidget(context, message as UnsupportedMessage);
      case MessageType.audio:
        return _tagAudioWidget(context, message as AudioMessage);
      case MessageType.video:
        return _tagVideoWidget(context, message as VideoMessage);
      case MessageType.emoji:
        return _tagEmojiWidget(context, message as EmojiMessage);
      case MessageType.gif:
        return _tagGiphyWidget(context, message as GifMessage);
      // case MessageType.location:
      //   return _tagLocationWidget(context, message as LocationMessage);

      case MessageType.location:
        // TODO: Handle this case.
        break;
    }
    return null;
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
