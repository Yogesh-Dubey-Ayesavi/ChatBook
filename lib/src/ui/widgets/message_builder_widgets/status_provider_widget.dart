part of '../../../../chatbook.dart';

class StatusProviderWidget extends StatelessWidget {
  const StatusProviderWidget({Key? key, required this.messageNotifier})
      : super(key: key);

  final ValueNotifier<Message> messageNotifier;

  @override
  Widget build(BuildContext context) {
    Widget _statusProvider(Message message) {
      switch (message.status) {
        case Status.seen:
          return SvgPicture.asset(
            'assets/double_tick.svg',
            color: Colors.blue,
            height: 10,
            width: 10,
          );
        case Status.delivered:
          return SvgPicture.asset(
            'assets/double_tick.svg',
            color: Colors.grey,
            height: 10,
            width: 10,
          );
        case Status.error:
          return const Icon(Icons.error_outline, color: Colors.red, size: 18);
        case Status.sending:
          return const SizedBox(
              height: 10, width: 10, child: CupertinoActivityIndicator());
        case Status.sent:
          return SvgPicture.asset(
            'asset/single_tick.svg',
            color: Colors.grey,
            height: 10,
            width: 10,
          );
        default:
          return const SizedBox();
      }
    }

    return ValueListenableBuilder(
        valueListenable: messageNotifier,
        builder: (_, value, __) {
          return _statusProvider(value as Message);
        });
  }
}
