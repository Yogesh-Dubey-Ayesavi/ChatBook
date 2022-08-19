part of '../../chatbook.dart';

class ChatBook extends StatefulWidget {
  const ChatBook({
    Key? key,
    required this.messages,
    required this.theme,
    this.onSendMessage
  }) : super(key: key);

  final List <Message> messages;
  final ChatTheme theme;
  final void Function(String text)? onSendMessage;

  @override
  State<ChatBook> createState() => _ChatBookState();
}

class _ChatBookState extends State<ChatBook> {
  @override
  Widget build(BuildContext context) {
    return InheritedChatTheme(
      theme: widget.theme,
      child: InheritedMessagesWidget(
        messages: widget.messages,
        child: Column(
          children:
           <Widget> [
             Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.00,),
                  child: MessageList(),
              ),
            ),
             const SizedBox(height: 10,),
               ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 150 ,minHeight: 50 ),
              child:  InputBar(
                onSendMessage: widget.onSendMessage,
              )
            )
          ],
        ),
      ),
    ) ;
  }
}
