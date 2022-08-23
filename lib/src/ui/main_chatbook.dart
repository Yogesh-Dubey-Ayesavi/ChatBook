part of '../../chatbook.dart';

/// This is the entry point of the [ChatBook] package.

class ChatBook extends StatefulWidget {
  const ChatBook(
      {Key? key,
      required this.messages,
      required this.onGiphyPressed,
      this.theme = const DefaultChatTheme(),
      this.onSendMessage,
      this.giphyApiKey,
      this.onPressMic,
      this.onMicPressEnded})
      : super(key: key);

  /// List of messages from which messagefor [Ayesavi ChatBook] will be retrieved by default this field is provided [DefaultChatTheme]
  final List<Message> messages;

  /// Theme assigned to ChatBook for info see [ChatTheme]
  final ChatTheme theme;

  /// Callback for onPress event on giphy or emoji.
  final void Function(GiphyGif giphy)? onGiphyPressed;

  /// callback for onPress event on sendMessageButton in inputbar [InputBar]
  final void Function(String text)? onSendMessage;

  /// GiphyApiKey required to retrieve giphy from servers.
  final String? giphyApiKey;

  /// Callback for onPressMic event
  final void Function()? onPressMic;

  final void Function(String path,int duration)? onMicPressEnded;

  @override
  State<ChatBook> createState() => _ChatBookState();
}

class _ChatBookState extends State<ChatBook> {
  /// Initialising ItemScrollController
  /// It is needed for jumpTo and scrollTo methods to reach any particular item
  final ItemScrollController itemScrollController = ItemScrollController();

  /// Initialising ItemPositionListner
  /// Listens for the position of any item.
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  /// It is for holding the selectedGif after onPressedEvent on Gif
  GiphyGif? currentGif;

  /// GiphyCient is later initilising the [GiphyClient] in the [initState] method.
  late GiphyClient client;

  /// System used to generate random id for the user at the runtime by default initialised with aan empty String
  String randomId = "";

  /// For holding giphy Api Key
  //! Store API keys in the env mode separate it is advised so to keep your API keys private to you only

  @override
  void initState() {
    super.initState();
    if (widget.giphyApiKey != null) {
      client = GiphyClient(apiKey: widget.giphyApiKey!, randomId: '');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        client.getRandomId().then((value) {
          setState(() {
            randomId = value;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GiphyGetWrapper(

        /// GiphyGetWrapper is used to get giphys where ever called in the application.
        giphy_api_key: widget.giphyApiKey!,
        builder: (stream, giphyGetWrapper) {
          stream.listen((gif) {
            widget.onGiphyPressed?.call(gif);
            setState(() {
              currentGif = gif;
            });
          });

          return InheritedChatTheme(
            theme: widget.theme,
            //* Needed for inheriting acess of messages to all its child widgets.
            child: InheritedMessagesWidget(
              messages: widget.messages,
              child: InheritedGifMessageGetWrapper(
                giphyGetWrapper: giphyGetWrapper,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.00,
                        ),
                        child: MessageList(
                          controller: itemScrollController,
                          positionsListener: itemPositionsListener,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: 150, minHeight: 50),
                        child: InputBar(
                          giphyGetWrapper: giphyGetWrapper,
                          currentGif: currentGif,
                          onSendMessage: widget.onSendMessage,
                          onPressMic: widget.onPressMic,
                          onMicPressEnded: widget.onMicPressEnded,
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
