part of '../../../chatbook.dart';

class InputBar extends StatefulWidget {
  const InputBar(
      {Key? key,
      this.onSendMessage,
      this.currentGif,
      required this.giphyGetWrapper})
      : super(key: key);

  final void Function(String text)? onSendMessage;
  final GiphyGif? currentGif;
  final GiphyGetWrapper giphyGetWrapper;
  @override
  State<InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {
  final TextEditingController _controller = InputTextFieldController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _handleSendPressed(String text) {
    if (text.trim() != '') {
      widget.onSendMessage?.call(text.trim());
      _controller.clear();
    }
  }

  void onGiphyPressed() {
    if (widget.currentGif != null) {}
  }

  @override
  Widget build(BuildContext context) {
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
                    event.isKeyPressed(LogicalKeyboardKey.enter)) {
                  _handleSendPressed(_controller.text);
                } else if (kIsWeb &&
                    event.isAltPressed &&
                    event.isKeyPressed(LogicalKeyboardKey.keyS)) {
                  widget.giphyGetWrapper.getGif('', context);
                }
              },
              child: CupertinoTextField(
                autofocus: true,
                controller: _controller,
                placeholder: 'Type a message',
                placeholderStyle:
                    const TextStyle(color: Color.fromRGBO(255, 255, 255, .4)),
                minLines: 1,
                maxLines: 65536,
                cursorColor: const Color(0XFF005FFF),
                style: const TextStyle(color: Colors.white),
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Transform.rotate(
                  angle: 87,
                  child: const Icon(
                    Icons.attachment_outlined,
                    color: Colors.white,
                  ))),
          IconButton(
              onPressed: () {
                _handleSendPressed(_controller.text.trim());
              },
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
