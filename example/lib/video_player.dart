
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';



class VideoApp extends StatefulWidget {

  const VideoApp({Key?key}):super(key:key);

  @override
    _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {


  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }


  @override
  Widget build(context){
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller)):Container(
      height: 40,
      color: Colors.black,);

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}