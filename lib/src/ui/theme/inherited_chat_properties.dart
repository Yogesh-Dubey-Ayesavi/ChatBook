part of '../../../chatbook.dart';

class InheritedProperties extends InheritedWidget {
  /// It inherits one common theme among all its child widgets.

  const InheritedProperties({
    Key? key,
    required Widget child,
    required this.theme,
    required this.giphyGetWrapper,
    required this.tagHelper,
    required this.author,
  }) : super(key: key, child: child);

  final ChatTheme theme;
  final TagMessageHelper tagHelper;
  final GiphyGetWrapper giphyGetWrapper;
  final User author;
  static InheritedProperties of(BuildContext context) {
    final InheritedProperties? result =
        context.dependOnInheritedWidgetOfExactType<InheritedProperties>();
    assert(result != null, 'No InheritedProperties found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedProperties oldWidget) {
    return oldWidget.theme != theme &&
        oldWidget.tagHelper != tagHelper &&
        oldWidget.giphyGetWrapper != giphyGetWrapper &&
        oldWidget.author != author;
  }
}
