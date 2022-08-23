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
  runApp(ChatBookApp());
}

class ChatBookApp extends StatelessWidget {
  const ChatBookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Message> _messages = [];

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
                    children: <Widget>[
                      Text(
                        "Kriss Benawat",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: GoogleFonts.poppins(
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
        giphyApiKey: 'Hbruc2uiEvkJKgCIrZw3n68ukoiycsUu',
        onSendMessage: (String messageText) {
          setState(() {
            _messages.insert(
                0,
                TextMessage(
                    author: const User(id: ""),
                    id: 'id',
                    text: messageText,
                    createdAt: DateTime.now().microsecondsSinceEpoch,
                    self: true,
                    status: Status.seen));
          });
        },
        messages: _messages,
        onPressMic: () {
          // print("occured");
          setState(() {
            _messages.insert(
                0,
                AudioMessage(
                    author: const User(id: ""),
                    size: 135,
                    name: 'AudioFile',
                    self: true,
                    id: DateTime.now().microsecondsSinceEpoch.toString(),
                    type: MessageType.audio,
                    createdAt: DateTime.now().microsecondsSinceEpoch,
                    uri:
                        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'));
          });
          ;
        },
        onMicPressEnded: (path, duration) {
          setState(() {
            _messages.insert(
                0,
                AudioMessage(
                    author: const User(id: ""),
                    size: duration,
                    name: 'AudioFile',
                    self: true,
                    id: DateTime.now().microsecondsSinceEpoch.toString(),
                    type: MessageType.audio,
                    createdAt: DateTime.now().microsecondsSinceEpoch,
                    uri: path));
          });
        },
        onGiphyPressed: (GiphyGif giphy) {
          setState(() {
            _messages.insert(
                0,
                GifMessage(
                    author: const User(id: ""),
                    id: 'id',
                    gif: giphy,
                    type: MessageType.gif,
                    createdAt: DateTime.now().microsecondsSinceEpoch,
                    self: true,
                    status: Status.seen));
          });
        },
      ),
    );
  }
}

// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:record/record.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AudioRecorder(),
//     );
//   }
// }

// class AudioRecorder extends StatefulWidget {
//   const AudioRecorder({Key? key}) : super(key: key);

//   @override
//   State<AudioRecorder> createState() => _AudioRecorderState();
// }

// class _AudioRecorderState extends State<AudioRecorder> {
//   late Record record;

//   @override
//   void initState() {
//     record = Record();
//     super.initState();
//   }

//   void start() async {
//     if (await record.hasPermission()) {
//       await record.start(
//         path: 'aFullPath/myFile.m4a',
//         encoder: AudioEncoder.aacLc, // by default
//         bitRate: 128000, // by default
//       );
//     }
//   }

//   void stop() async {
//     await record.stop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(children: [
//         IconButton(
//             onPressed: () {
//               start();
//             },
//             icon: const Icon(Icons.play_arrow)),
//         IconButton(
//             onPressed: () {
//               stop();
//             },
//             icon: const Icon(Icons.play_arrow))
//       ]),
//     );
//   }
// }
