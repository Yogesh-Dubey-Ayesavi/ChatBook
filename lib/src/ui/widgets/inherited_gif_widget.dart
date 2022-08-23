part of '../../../chatbook.dart';

class InheritedGifMessageGetWrapper extends InheritedWidget {
  /// For acessing [giphyGetWrapper] within it's child widgets see [GiphyGetWrapper] builder method and properties.
  /// for more info regarding giphyGetWrapper refer to https://www.giphy.com
  const InheritedGifMessageGetWrapper({
    Key? key,
    required Widget child,
    required this.giphyGetWrapper,
  }) : super(key: key, child: child);

  final GiphyGetWrapper giphyGetWrapper;

  static InheritedGifMessageGetWrapper of(BuildContext context) {
    final InheritedGifMessageGetWrapper? result = context
        .dependOnInheritedWidgetOfExactType<InheritedGifMessageGetWrapper>();
    assert(result != null, 'No InheritedGifMessageGetWrapper found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedGifMessageGetWrapper old) {
    return old.giphyGetWrapper != giphyGetWrapper;
  }
}
