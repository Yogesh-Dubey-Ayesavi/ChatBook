part of '../../chatbook.dart';

/// This is the entry point of the [ChatBook] package.

class ChatBook extends StatefulWidget {
  const ChatBook({
    Key? key,
    required this.author,
    required this.onSendMessage,
    this.theme = const DefaultChatTheme(),
    this.giphyApiKey,
  }) : super(key: key);

  /// List of messages from which messagefor [Ayesavi ChatBook] will be retrieved by default this field is provided [DefaultChatTheme]

  /// Theme assigned to ChatBook for info see [ChatTheme]
  final ChatTheme theme;

  /// callback for onPress event on sendMessageButton in inputbar [InputBar]
  final void Function(Message currentMessage) onSendMessage;

  /// GiphyApiKey required to retrieve giphy from servers.
  final String? giphyApiKey;

  final User author;

  @override
  State<ChatBook> createState() => _ChatBookState();
}

class _ChatBookState extends State<ChatBook> {
  final List<MessageBuilder> _messages = [];

  /// Initialising ItemScrollController
  /// It is needed for jumpTo and scrollTo methods to reach any particular item
  final ItemScrollController itemScrollController = ItemScrollController();

  /// Initialising ItemPositionListner
  /// Listens for the position of any item.
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final TagMessageHelper _tagMessageHelper = TagMessageHelper();

  /// It is for holding the selectedGif after onPressedEvent on Gif

  /// GiphyCient is later initilising the [GiphyClient] in the [initState] method.
  late GiphyClient client;

  /// System used to generate random id for the user at the runtime by default initialised with aan empty String
  String randomId = "";

  /// For holding giphy Api Key
  //! Store API keys in the env mode separate it is advised so to keep your API keys private to you only

  bool _isScrollToBottomVisible = false;

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
    _autoGetPosition();
  }

  void _autoGetPosition() {
    Future.delayed(const Duration(milliseconds: 500), () {
      itemScrollController.scrollListener(
        (position, maxExtent) {
          _isScrollToBottomVisible =
              !((position.abs() - maxExtent.abs()).abs() < 500);
          setState(() {});
        },
      );
    });
  }

  void autoScroll(
    int index, {
    Duration duration = const Duration(milliseconds: 200),
    bool scrollToMax = false,
  }) {
    if (_messages.isNotEmpty) {
      itemScrollController
          .scrollTo(index: index, duration: duration, curve: Curves.easeInCubic)
          .then((value) {
        if (scrollToMax) {
          itemScrollController.scrollToMax(
              curve: Curves.easeInCubic,
              duration: const Duration(milliseconds: 50));
          _isScrollToBottomVisible = false;
          setState(() {});
        }
      });

      Future.delayed(const Duration(milliseconds: 200), _autoGetPosition);
    }
  }

  void onPressSend(
    Message sendingMessage,
  ) {
    _messages.add(MessageBuilder(
        message: ValueNotifier(sendingMessage),
        prevMessage: _messages.isNotEmpty ? _messages.last.message : null));
    setState(() {});
    widget.onSendMessage.call(sendingMessage.copyWith(
      self: false,
    ));
    Future.delayed(const Duration(milliseconds: 50), () {
      autoScroll(
        _messages.length - 1,
        scrollToMax: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GiphyGetWrapper(

        /// GiphyGetWrapper is nused to get giphys where ever called in the application.
        giphy_api_key: widget.giphyApiKey!,
        builder: (stream, giphyGetWrapper) {
          stream.listen((gif) {
            // widget.onGiphyPressed?.call(gif);
            onPressSend(GifMessage(
                author: const User(id: ""),
                id: '',
                gif: gif,
                createdAt: DateTime.now().millisecondsSinceEpoch,
                self: true,
                status: Status.seen));
          });

          return InheritedProperties(
            scrollTo: autoScroll,
            tagHelper: _tagMessageHelper,
            theme: widget.theme,
            giphyGetWrapper: giphyGetWrapper,
            author: widget.author,
            //* Needed for inheriting acess of messages to all its child widgets.
            child: InheritedMessagesWidget(
              messages: _messages,
              child: Stack(
                children: [
                  Column(
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
                      // RepaintBoundary(
                      // child:
                      ValueListenableBuilder(
                          valueListenable: _tagMessageHelper.tagNotifier,
                          builder: (_, value, __) {
                            if (value == null) return const SizedBox();
                            return TaggedMessageIndicator(
                                message: value as Message);
                          }),
                      // ),
                      ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxHeight: 150, minHeight: 60),
                          child: InputBar(
                            giphyGetWrapper: giphyGetWrapper,
                            onSendMessage: onPressSend,
                          ))
                    ],
                  ),
                  Positioned(
                    bottom: 100,
                    right: 20,
                    child: Visibility(
                        visible: _isScrollToBottomVisible,
                        child: CircleAvatar(
                          backgroundColor: Color(0XFF191919),
                          child: IconButton(
                            onPressed: () {
                              autoScroll(_messages.length - 1,
                                  duration: const Duration(seconds: 2));
                            },
                            icon: const Icon(CupertinoIcons.arrow_down,
                                color: Colors.white),
                          ),
                        )),
                  )
                ],
              ),
            ),
          );
        });
  }
}
