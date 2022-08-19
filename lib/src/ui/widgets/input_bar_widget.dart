part of '../../../chatbook.dart';



class InputBar extends StatefulWidget {
  const InputBar({Key? key,this.onSendMessage,this.currentGif,required this.giphyGetWrapper}) : super(key: key);

  final void Function(String text)? onSendMessage;
  final GiphyGif? currentGif;
  final GiphyGetWrapper giphyGetWrapper;
  @override
  State<InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {

  final  TextEditingController _controller = InputTextFieldController();


  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }


  void _handleSendPressed(String text){
      widget.onSendMessage?.call(text);
      _controller.clear();
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      width: double.infinity,
      color: const Color(0XFF191919),
      child: Row(
        children:  [
            IconButton(onPressed:()async{
                             widget.giphyGetWrapper.getGif('', context);
                             }
    , icon: const Icon(Icons.emoji_emotions_outlined),color:const Color.fromRGBO(255, 255, 255, .5) ,),
             Expanded(
              child:  CupertinoTextField(
                controller: _controller,
                placeholder: 'Type a message',
                placeholderStyle: const TextStyle(color:  Color.fromRGBO(255, 255, 255, .4)),
                minLines: 1,
                maxLines: 65536,
                cursorColor: const Color(0XFF005FFF),
                style: const TextStyle(color: Colors.white),
                decoration: const BoxDecoration(
                  color: Colors.transparent
                ),
              ),
            ),
          IconButton(onPressed:(){},
              icon:  Transform.rotate(angle: 87 ,child: const Icon(Icons.attachment_outlined,color: Colors.white,))),
          IconButton(onPressed: (){
            if (_controller.text.trim() != ''){
              _handleSendPressed(_controller.text.trim());
            }
          }, icon:  const Icon(Icons.send,color: Colors.white,))
        ],
      ),
    );
  }
}
