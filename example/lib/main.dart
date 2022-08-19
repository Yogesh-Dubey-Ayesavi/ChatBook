// import 'package:example/video_player.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:video_player/video_player.dart';
// import 'dart:math';
// import 'package:flutter/material.dart';
//
// const minItemHeight = 20.0;
// const scrollDuration = Duration(seconds: 1);
//
// const randomMax = 25000;
//
// void main() {
//   runApp(ScrollablePositionedListExample());
// }
//
// class ScrollablePositionedListExample extends StatelessWidget {
//   const ScrollablePositionedListExample({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ScrollablePositionedList Example',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const ScrollablePositionedListPage(),
//     );
//   }
// }
//
// class ScrollablePositionedListPage extends StatefulWidget {
//   const ScrollablePositionedListPage({Key? key}) : super(key: key);
//
//   @override
//   _ScrollablePositionedListPageState createState() => _ScrollablePositionedListPageState();
// }
//
// class _ScrollablePositionedListPageState
//     extends State<ScrollablePositionedListPage> {
//   final ItemScrollController itemScrollController = ItemScrollController();
//   final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
//   late List<Color> itemColors;
//   List <int> itemsList = <int>[1];
//   VideoPlayerController _controller = VideoPlayerController.network(
//       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
//   bool reversed = false ;
//   double alignment = 0;
//   int numberOfItems = 10;
//   String imgUrl = 'https://static.remove.bg/remove-bg-web/f9c9a2813e0321c04d66062f8cca92aedbefced7/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png';
//

//
//
//   @override
//   void initState() {
//     super.initState();
//     _controller.initialize();
//
//     final heightGenerator = Random(328902348);
//     final colorGenerator = Random(42490823);
//
//     itemColors = List<Color>.generate(numberOfItems,
//             (int _) => Color(colorGenerator.nextInt(randomMax)).withOpacity(1));
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     floatingActionButton: Column(
//       children: [
//         FloatingActionButton(
//           onPressed: () {
//             jumpTo(itemsList.length);
//           setState(() {
//             itemsList.add(2);
//           });
//         },
//
//         ),  FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               scrollTo(Random().nextInt(numberOfItems));
//             });
//           },
//
//         ),
//       ],
//     ),
//       body: OrientationBuilder(
//       builder: (context, orientation) => Column(
//         children: <Widget>[
//           Expanded(
//             child: list(orientation),
//           ),
//             Row(
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   scrollControlButtons,
//                   const SizedBox(height: 10),
//                   jumpControlButtons,
//                   alignmentControl,
//                 ],
//               ),
//             ],
//           )
//         ],
//       ),
//     ),
//   );
//
//   Widget get alignmentControl => Row(
//     mainAxisSize: MainAxisSize.max,
//     children: <Widget>[
//       const Text('Alignment: '),
//       SizedBox(
//         width: 200,
//         child: SliderTheme(
//           data: SliderThemeData(
//             showValueIndicator: ShowValueIndicator.always,
//           ),child: Slider(
//             value: alignment,
//             label: alignment.toStringAsFixed(2),
//             onChanged: (double value) => setState(() => alignment = value),
//           ),
//         ),
//       ),
//     ],
//   );
//
//   Widget list(Orientation orientation) => ScrollablePositionedList.builder(
//     itemCount: itemsList.length,
//         itemBuilder: (context, index) => item(index, orientation),
//     itemScrollController: itemScrollController,
//     reverse: reversed,
//     scrollDirection: Axis.vertical,
//   );
//
//   Widget get positionsView => ValueListenableBuilder<Iterable<ItemPosition>>(
//     valueListenable: itemPositionsListener.itemPositions,
//     builder: (context, positions, child) {
//       int? min;
//       int? max;
//       if (positions.isNotEmpty) {
//
//         min = positions
//             .where((ItemPosition position) => position.itemTrailingEdge > 0)
//             .reduce((ItemPosition min, ItemPosition position) =>
//         position.itemTrailingEdge < min.itemTrailingEdge
//             ? position
//             : min)
//             .index;
//
//         max = positions
//             .where((ItemPosition position) => position.itemLeadingEdge < 1)
//             .reduce((ItemPosition max, ItemPosition position) =>
//         position.itemLeadingEdge > max.itemLeadingEdge
//             ? position
//             : max)
//             .index;
//       }
//       return Row(
//         children: <Widget>[
//           Expanded(child: Text('First Item: ${min ?? ''}')),
//           Expanded(child: Text('Last Item: ${max ?? ''}')),
//           const Text('Reversed: '),
//           Checkbox(
//               value: reversed,
//               onChanged: (bool? value) => setState(() {
//                 reversed = value!;
//               }))
//         ],
//       );
//     },
//   );
//
//   Widget get scrollControlButtons => Row(
//     children: <Widget>[
//       const Text('scroll to'),
//       scrollButton(0),
//       scrollButton(5),
//       scrollButton(10),
//       scrollButton(100),
//       scrollButton(1000),
//       scrollButton(99809),
//     ],
//   );
//
//   Widget get jumpControlButtons => Row(
//     children: <Widget>[
//       const Text('jump to'),
//       jumpButton(0),
//       jumpButton(5),
//       jumpButton(10),
//       jumpButton(100),
//       jumpButton(1000),
//       jumpButton(229999),
//     ],
//   );
//
//     Widget _itemProvider(int idx,int i){
//       if (idx == 1){
//        return  Stack(
//          children: [
//            Image.network(imgUrl),
//            Text("$i",style: const TextStyle(color: Colors.white54),)
//          ],
//        );
//       }
//       else if (idx == 0){
//         return Stack(
//           children: [
//             const VideoApp(),
//             Text("$i",style: const TextStyle(color: Colors.white54),)
//           ],
//         );
//       }
//       else if  (idx == 2){
//         return Text(' ${generateRandomString(Random().nextInt(2000))}  ', style: const TextStyle(color: Colors.white),);
//       }
//       else {
//         return const Text("");
//       }
//
//     }
//
//   final _scrollButtonStyle = ButtonStyle(
//     padding: MaterialStateProperty.all(
//       const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//     ),
//     minimumSize: MaterialStateProperty.all(Size.zero),
//     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//   );
//
//   Widget scrollButton(int value) => TextButton(
//     key: ValueKey<String>('Scroll$value'),
//     onPressed: () => scrollTo(value),
//     child: Text('$value'),
//     style: _scrollButtonStyle,
//   );
//
//   Widget jumpButton(int value) => TextButton(
//     key: ValueKey<String>('Jump$value'),
//     onPressed: () => jumpTo(value),
//     child: Text('$value'),
//     style: _scrollButtonStyle,
//   );
//
//   void scrollTo(int index) => itemScrollController.scrollTo(
//       index: index,
//       duration: scrollDuration,
//       curve: Curves.easeInOutCubic,
//   );
//
//   void jumpTo(int index) =>
//       itemScrollController.jumpTo(index: index, alignment: alignment);
//
//   /// Generate item number [i].
//   Widget item(int i, Orientation orientation) {
//     return SizedBox(
//       // height: orientation == Orientation.portrait ? itemHeights[i] : null,
//       child: Container(
//         child: Center(
//             child:_itemProvider(itemsList[i],i)
//         ),
//       ),
//     );
//   }
//
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }




import 'dart:math';
import 'package:chatbook/chatbook.dart';
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart" show GoogleFonts;

void main(){
  runApp(const ChatBookApp());
}

class ChatBookApp extends StatelessWidget {
  const ChatBookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme()
      ),
      home:const HomePage() ,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List <TextMessage>_messages = [
    const TextMessage(author: User(id: ""), id: 'id', text: '@my  **https://www.thereverseland.com/** lorem ip ',createdAt: 1092076200000,self: true),
    const TextMessage(author:  User(id: ""), id: 'id', text: 'my  https://www.youtube.com/watch?v=1Oq9HCIlM1A lorem ip ',createdAt: 1092076200000,self: true),
    const TextMessage(author:  User(id: ""), id: 'id', text: 'my  https://www.thereverseland.com/ lorem ip ',createdAt: 102078000,self: true)];



  String generateRandomString(int len) {
    var r = Random();
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  
  @override
  Widget build(BuildContext context) {


    return  Scaffold(


      backgroundColor: const Color(0XFF010101),
      body: ChatBook(
        theme: const DefaultChatTheme(),
        onSendMessage: (String messageText){
          setState(() {
            _messages.add(TextMessage(author: const User(id: ""), id: 'id', text: messageText,createdAt: DateTime.now().microsecondsSinceEpoch,self: true,status: Status.seen));
          });
        },
        messages: _messages,),
    );
  }
}



















