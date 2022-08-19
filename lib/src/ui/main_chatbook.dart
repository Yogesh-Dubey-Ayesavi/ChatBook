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


  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  GiphyGif? currentGif = null;

  late GiphyClient client;

  String randomId = "";

  String? giphyApiKey = '';


  @override
  void initState() {
    super.initState();
    client = GiphyClient(apiKey: giphyApiKey!, randomId: '');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      client.getRandomId().then((value) {
        setState(() {
          randomId = value;
        });
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return GiphyGetWrapper(giphy_api_key: giphyApiKey!, builder: (stream,giphyGetWrapper){
      stream.listen((gif) {
        setState(() {
          currentGif = gif;
        });
      });


      void onSendMessage(String text){

         widget.onSendMessage!(text);
      }


    return InheritedChatTheme(
      theme: widget.theme,
      child: InheritedMessagesWidget(
        messages: widget.messages,
        child: Column(
          children:
           <Widget> [
             Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.00,),
                  child: MessageList(
                    controller: itemScrollController,
                    positionsListener: itemPositionsListener,
                  ),
              ),
            ),
             const SizedBox(height: 10,),
               ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 150 ,minHeight: 50 ),
                child:  InputBar(
                  giphyGetWrapper : giphyGetWrapper,
                  currentGif : currentGif,
                  onSendMessage: onSendMessage,
              )
            )
          ],
        ),
      ),
    ) ;
    });
  }
}
