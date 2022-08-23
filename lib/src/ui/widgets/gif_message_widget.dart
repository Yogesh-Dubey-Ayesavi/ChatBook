part of '../../../chatbook.dart';

class GifMessageWidget extends StatefulWidget {
  const GifMessageWidget({Key? key, required this.message}) : super(key: key);
  final GifMessage message;

  @override
  State<GifMessageWidget> createState() => _GifMessageWidgetState();
}

class _GifMessageWidgetState extends State<GifMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GiphyGifWidget(
        imageAlignment: Alignment.centerRight,
        gif: widget.message.gif,
        borderRadius: BorderRadius.circular(6),
        giphyGetWrapper:
            InheritedGifMessageGetWrapper.of(context).giphyGetWrapper,
        showGiphyLabel: true,
      ),
    );
  }
}
