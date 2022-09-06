part of '../../../../chatbook.dart';

class DateProvider extends StatelessWidget {
  const DateProvider({Key? key, required this.message, this.prevMessage})
      : super(key: key);

  final Message message;
  final Message? prevMessage;

  @override
  Widget build(BuildContext context) {
    Widget _dateProvider(Message currentMessage, Message? prevMessage) {
      if (prevMessage != null &&
          sameDay(currentMessage.createdAt!, prevMessage.createdAt) == false) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            DateFormat('dd MMM yyyy').format(
                DateTime.fromMillisecondsSinceEpoch(currentMessage.createdAt!)),
            style: InheritedProperties.of(context).theme.dateHeaderTextStyle,
          ),
        );
      } else if (prevMessage == null) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            DateFormat('dd MMM yyyy').format(
                DateTime.fromMillisecondsSinceEpoch(currentMessage.createdAt!)),
            style: InheritedProperties.of(context).theme.dateHeaderTextStyle,
          ),
        );
      } else {
        return const SizedBox();
      }
    }

    return SizedBox(child: _dateProvider(message, prevMessage));
  }
}
