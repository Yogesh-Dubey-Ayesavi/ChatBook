part of '../../../chatbook.dart';

class InputBar extends StatefulWidget {
  const InputBar(
      {Key? key,
      this.onSendMessage,
      this.currentGif,
      this.onPressMic,
      this.onMicPressEnded,
      required this.giphyGetWrapper})
      : super(key: key);

  final void Function(String text)? onSendMessage;
  final void Function()? onPressMic;
  final GiphyGif? currentGif;
  final GiphyGetWrapper giphyGetWrapper;
  final void Function(String path, double duration)? onMicPressEnded;
  @override
  State<InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {
  final TextEditingController _controller = InputTextFieldController();
  bool _isSendButtonVisible = false;
  late RecorderHelper _recorderHelper;

  @override
  void initState() {
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

  void _handleSendPressed(String text) {
    widget.onSendMessage?.call(text);
    _controller.clear();
  }

  void onGiphyPressed() {
    if (widget.currentGif != null) {}
  }

  void onPressMic() {
    widget.onPressMic?.call();
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
    if (_controller.text.trim() != '') {
      _isSendButtonVisible = true;
    } else {
      _isSendButtonVisible = false;
    }

    return Container(
      width: double.infinity,
      color: const Color(0XFF191919),
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
                    _handleSendPressed(_controller.text.trim());
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
              onPressed: () {},
              icon: Transform.rotate(
                  angle: 87,
                  child: const Icon(
                    Icons.attachment_outlined,
                    color: Colors.white,
                  ))),
          _isSendButtonVisible == true
              ? IconButton(
                  onPressed: () {
                    _handleSendPressed(_controller.text.trim());
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
                                  widget.onMicPressEnded
                                      ?.call(map['path'], map['duration'])
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
