part of '../../../../chatbook.dart';

class RepliedMessageWidget extends StatefulWidget {
  const RepliedMessageWidget({Key? key, required this.repliedMessage})
      : super(key: key);

  final Message repliedMessage;

  @override
  State<RepliedMessageWidget> createState() => _RepliedMessageWidgetState();
}

class _RepliedMessageWidgetState extends State<RepliedMessageWidget> {
  Widget? _leadingWidgetProvider(Message repliedMessage) {
    switch (repliedMessage.type) {
      case MessageType.custom:
        // TODO: Handle this case.
        break;
      case MessageType.file:
        // TODO: Handle this case.
        break;
      case MessageType.image:
        // TODO: Handle this case.
        break;
      case MessageType.system:
        // TODO: Handle this case.
        break;
      case MessageType.text:
        return null;
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

  Widget? _subtitleProvider(Message repliedMessage) {
    switch (repliedMessage.type) {
      case MessageType.custom:
        // TODO: Handle this case.
        break;
      case MessageType.file:
        // TODO: Handle this case.
        break;
      case MessageType.image:
        // TODO: Handle this case.
        break;
      case MessageType.system:
        // TODO: Handle this case.
        break;
      case MessageType.text:
        repliedMessage as TextMessage;
        return Text(repliedMessage.text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: InheritedProperties.of(context).theme.subtitleTextStyle);
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
    return Card(
        color: Colors.grey[800],
        child: ListTile(
          onTap: () {
            //TODO fetch index of the message replyingTo:
            InheritedProperties.of(context).scrollTo(0);
          },
          leading: _leadingWidgetProvider(widget.repliedMessage),
          title: widget.repliedMessage.self == true
              ? Text('You',
                  style: InheritedProperties.of(context).theme.labelTextStyle)
              : Text(
                  widget.repliedMessage.author.firstName!,
                  style: InheritedProperties.of(context).theme.labelTextStyle,
                ),
          subtitle: _subtitleProvider(widget.repliedMessage),
        ));
  }
}
