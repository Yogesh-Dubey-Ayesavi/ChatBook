part of '../../../../chatbook.dart';

class SystemMessageWidget extends StatelessWidget {
  const SystemMessageWidget({Key? key, required this.systemMessage})
      : super(key: key);

  final SystemMessage systemMessage;
  @override
  Widget build(BuildContext context) {
    return Container(   
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        // alignment: Alignment.center,
        decoration: BoxDecoration(
            color: const Color(0XFF191919),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          systemMessage.text,
          textAlign: TextAlign.center,
          style: InheritedProperties.of(context).theme.systemMessageTextStyle,
        ));
  }
}
