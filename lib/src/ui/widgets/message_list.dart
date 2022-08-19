part of '../../../chatbook.dart';



class MessageList extends StatefulWidget {
  const MessageList({Key? key}) : super(key: key);
  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {


  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();





  @override
  Widget build(BuildContext context) {


    return ScrollablePositionedList.builder(
        itemCount: InheritedMessagesWidget.of(context).messages.length,
        itemBuilder: (_,index){
          return MessageBuilder(
                    message: InheritedMessagesWidget.of(context).messages[index],
                    prevMessage: index != 0?InheritedMessagesWidget.of(context).messages[index-1]:null,
          );
        },
       scrollDirection: Axis.vertical,
    );
  }
}


