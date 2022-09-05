import 'dart:io';
import 'dart:math';
import 'package:chatbook/chatbook.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:giphy_get/l10n.dart';
import "package:google_fonts/google_fonts.dart" show GoogleFonts;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:just_audio_background/just_audio_background.dart';

Future<void> main() async {
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );
  runApp(const ChatBookApp());
}

class ChatBookApp extends StatelessWidget {
  const ChatBookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0Xff010101),
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.chevron_back,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  // backgroundImage: NetworkImage(
                  //     "https://randomuser.me/api/portraits/men/5.jpg"
                  //     ),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Kriss Benawat",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.phone,
                    color: Color.fromRGBO(255, 255, 255, .87),
                  ),
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.video_camera,
                    color: Color.fromRGBO(255, 255, 255, .87),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0XFF010101),
      body: ChatBook(
        author: const User(id: "1", firstName: "Yogesh"),
        giphyApiKey: 'Hbruc2uiEvkJKgCIrZw3n68ukoiycsUu',
        onSendMessage: (Message message) {
          // print(message.self);
        },
      ),
    );
  }
}

// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_editor_plus/image_editor_plus.dart';

// void main() {
//   runApp(
//     const MaterialApp(
//       home: ImageEditorExample(),
//     ),
//   );
// }

// class ImageEditorExample extends StatefulWidget {
  
//   const ImageEditorExample({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _ImageEditorExampleState createState() => _ImageEditorExampleState();
// }

// class _ImageEditorExampleState extends State<ImageEditorExample> {
//   Uint8List? imageData;

//   @override
//   void initState() {
//     super.initState();
//     loadAsset("image.jpg");
//   }

//   void loadAsset(String name) async {
//     var data = await rootBundle.load('assets/$name');
//     setState(() => imageData = data.buffer.asUint8List());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("ImageEditor Example"),
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (imageData != null) Image.memory(imageData!),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             child: const Text("Single image editor"),
//             onPressed: () async {
//               var editedImage = await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ImageEditor(
//                     image: imageData,
//                   ),
//                 ),
//               );

//               // replace with edited image
//               if (editedImage != null) {
//                 imageData = editedImage;
//                 setState(() {});
//               }
//             },
//           ),
//           ElevatedButton(
//             child: const Text("Multiple image editor"),
//             onPressed: () async {
//               var editedImage = await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ImageEditor(
//                     images: [
//                       imageData,
//                       imageData,
//                     ],
//                     allowMultiple: true,
//                     allowCamera: true,
//                     allowGallery: true,
//                   ),
//                 ),
//               );

//               // replace with edited image
//               if (editedImage != null) {
//                 imageData = editedImage;
//                 setState(() {});
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
