part  of '../../../chatbook.dart';

class InheritedChatTheme extends InheritedWidget {
  const InheritedChatTheme( {
    Key? key,
    required Widget child,
    required ChatTheme this.theme,
  }) : super(key: key, child: child);


  final ChatTheme theme;
  static InheritedChatTheme of(BuildContext context) {
    final InheritedChatTheme? result =
        context.dependOnInheritedWidgetOfExactType<InheritedChatTheme>();
    assert(result != null, 'No InheritedChatTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedChatTheme old) {
    return old.theme!= theme ;
  }

}
