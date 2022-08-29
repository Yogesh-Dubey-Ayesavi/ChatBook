part of '../../../chatbook.dart';

class InputBar extends StatefulWidget {
  const InputBar({Key? key, this.onSendMessage, required this.giphyGetWrapper})
      : super(key: key);

  final void Function(Message message)? onSendMessage;
  final GiphyGetWrapper giphyGetWrapper;
  @override
  State<InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {
  final TextEditingController _controller = InputTextFieldController();

  final ImagePicker _picker = ImagePicker();

  late XFile? image;

  late FocusNode _focusNode;

  bool _isSendButtonVisible = false;
  late RecorderHelper _recorderHelper;

  @override
  void initState() {
    _focusNode = FocusNode();
    _recorderHelper = RecorderHelper();
    _recorderHelper.init();
    _controller.addListener(_handleTextControllerChange);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _recorderHelper.dispose();
    super.dispose();
  }

  void _handleSendPressed(Message currentMessage) {
    widget.onSendMessage?.call(currentMessage);
    _controller.clear();
    InheritedProperties.of(context).tagHelper.tagNotifier.value = null;
  }

  void _handleTextControllerChange() {
    setState(() {
      _isSendButtonVisible = _controller.text.trim() != '';
    });
  }

  Widget _buildTimer() {
    return ValueListenableBuilder(
      valueListenable: _recorderHelper.timerNotifier,
      builder: (_, value, __) {
        value as int;
        final String minutes = _formatNumber(value ~/ 60);
        final String seconds = _formatNumber(value % 60);
        return Text(
          '$minutes : $seconds',
          style: const TextStyle(color: Colors.red),
        );
      },
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }
    return numberStr;
  }

  @override
  Widget build(BuildContext context) {
    Future<String?> _getImage() async {
      image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      return image!.path;
    }

    final List<SharingOption> sharingOptions = <SharingOption>[
      SharingOption(
          icon: const Icon(Icons.photo_size_select_actual_outlined,
              color: Color(0xff005fff)),
          title: 'Image',
          onTap: () {
            _getImage().then((value) {
              if (value != null) {
                print(value);
                _handleSendPressed(ImageMessage(
                  author: InheritedProperties.of(context).author,
                  uri: value,
                  id: uuid.v4(),
                  repliedMessage: InheritedProperties.of(context)
                      .tagHelper
                      .tagNotifier
                      .value,
                  createdAt: DateTime.now().millisecondsSinceEpoch,
                  self: true,
                  name: '',
                  size: 10,
                  type: MessageType.image,
                ));
              }
            });
          }),
      SharingOption(
          icon: const Icon(
            Icons.music_note_outlined,
            color: Color(0xff005fff),
          ),
          title: 'Audio',
          onTap: () {}),
      SharingOption(
          icon: const Icon(CupertinoIcons.doc_text_fill,
              color: Color(0xff005fff)),
          title: 'Documents',
          onTap: () {}),
      SharingOption(
          icon: const Icon(
            Icons.location_on_outlined,
            color: Color(0xff005fff),
          ),
          title: 'Location',
          onTap: () {}),
      SharingOption(
          icon: const Icon(Icons.videocam_outlined, color: Color(0xff005fff)),
          title: 'Video',
          onTap: () {}),
      SharingOption(
          icon: const Icon(Icons.contacts_outlined, color: Color(0xff005fff)),
          title: 'Contacts',
          onTap: () {}),
    ];

    if (_controller.text.trim() != '') {
      _isSendButtonVisible = true;
    } else {
      _isSendButtonVisible = false;
    }

    return Container(
      width: double.infinity,
      color: InheritedProperties.of(context).theme.messageInputColor,
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              widget.giphyGetWrapper.getGif('', context);
            },
            icon: const Icon(Icons.emoji_emotions_outlined),
            color: const Color.fromRGBO(255, 255, 255, .5),
          ),
          Expanded(
            child: RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (event) {
                  if (kIsWeb &&
                      event.isControlPressed &&
                      event.isKeyPressed(LogicalKeyboardKey.enter) &&
                      _controller.text.trim() != '') {
                    _handleSendPressed(TextMessage(
                      author: InheritedProperties.of(context).author,
                      text: _controller.text.trim(),
                      id: uuid.v4(),
                      repliedMessage: InheritedProperties.of(context)
                          .tagHelper
                          .tagNotifier
                          .value,
                      createdAt: DateTime.now().millisecondsSinceEpoch,
                      self: true,
                    ));
                  } else if (kIsWeb &&
                      event.isAltPressed &&
                      event.isKeyPressed(LogicalKeyboardKey.keyS)) {
                    widget.giphyGetWrapper.getGif('', context);
                  }
                },
                child: ValueListenableBuilder(
                    valueListenable: _recorderHelper.recordStateNotifier,
                    builder: (_, value, __) {
                      switch (value) {
                        case RecordState.record:
                          return _buildTimer();
                        default:
                          return CupertinoTextField(
                            focusNode: _focusNode,
                            autofocus: true,
                            controller: _controller,
                            placeholder: 'Type a message',
                            placeholderStyle: const TextStyle(
                                color: Color.fromRGBO(255, 255, 255, .4)),
                            minLines: 1,
                            maxLines: 65536,
                            cursorColor: const Color(0XFF005FFF),
                            style: const TextStyle(color: Colors.white),
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                          );
                      }
                    })),
          ),
          IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                    backgroundColor: Colors.transparent,
                    constraints: const BoxConstraints(),
                    context: context,
                    builder: (_) {
                      return Container(
                          color: const Color(0Xff191919),
                          constraints: const BoxConstraints(
                              maxHeight: 250, minHeight: 0),
                          // padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: ListView.builder(
                              itemCount: sharingOptions.length,
                              itemBuilder: (BuildContext ctx, int i) {
                                return Card(
                                  margin: EdgeInsets.zero,
                                  color: Colors.transparent,
                                  child: ListTile(
                                    leading: sharingOptions[i].icon,
                                    title: Text(sharingOptions[i].title,
                                        style: InheritedProperties.of(context)
                                            .theme
                                            .labelTextStyle),
                                    onTap: sharingOptions[i].onTap,
                                  ),
                                );
                              }));
                    });
              },
              icon: Transform.rotate(
                  angle: 87,
                  child: const Icon(
                    Icons.attachment_outlined,
                    color: Colors.white,
                  ))),
          _isSendButtonVisible == true
              ? IconButton(
                  onPressed: () {
                    _handleSendPressed(TextMessage(
                      author: InheritedProperties.of(context).author,
                      text: _controller.text.trim(),
                      id: uuid.v4(),
                      repliedMessage: InheritedProperties.of(context)
                          .tagHelper
                          .tagNotifier
                          .value,
                      createdAt: DateTime.now().millisecondsSinceEpoch,
                      self: true,
                    ));
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ))
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: HoldDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        _recorderHelper.getPermission();
                      },
                      onHold: () {
                        _recorderHelper.isRecording().then((value) => {
                              if (!value) {_recorderHelper.startRecorder()}
                            });
                      },
                      holdTimeout: const Duration(milliseconds: 300),
                      onCancel: () {
                        logger.log("press Cancelled");
                        _recorderHelper.stop().then((map) => {
                              if (map!["path"] != null && map['duration'] != 0)
                                {
                                  _handleSendPressed(AudioMessage(
                                    author:
                                        InheritedProperties.of(context).author,
                                    name: "",
                                    id: uuid.v4(),
                                    createdAt:
                                        DateTime.now().millisecondsSinceEpoch,
                                    uri: map['path'],
                                    size: 200.00,
                                    self: true,
                                    repliedMessage:
                                        InheritedProperties.of(context)
                                            .tagHelper
                                            .tagNotifier
                                            .value,
                                  ))
                                }
                            });
                      },
                      child: const Icon(
                        Icons.mic,
                        color: Colors.white,
                      )),
                )
        ],
      ),
    );
  }
}

class SharingOption {
  const SharingOption(
      {required this.icon, required this.title, required this.onTap});

  final Icon icon;

  final String title;

  final void Function() onTap;
}
