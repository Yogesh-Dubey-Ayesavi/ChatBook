part of '../../../chatbook.dart';

class AudioMessageWidget extends StatefulWidget {
  const AudioMessageWidget({Key? key, required this.message}) : super(key: key);

  final AudioMessage message;

  @override
  State<AudioMessageWidget> createState() => _AudioMessageWidgetState();
}

class _AudioMessageWidgetState extends State<AudioMessageWidget> {
  late AudioHelper _audioHelper;

  @override
  void initState() {
    _audioHelper = AudioHelper();
    _audioHelper.init(widget.message.uri);
    super.initState();
  }

  @override
  void dispose() {
    _audioHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(
      children: [
        playBackStateButton(),
        const SizedBox(width: 10),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(
            right: 10.0,
            top: 5.0,
          ),
          child: progressBar(),
        )),
      ],
    ));
  }

  Widget playBackStateButton() {
    return ValueListenableBuilder(
        valueListenable: _audioHelper.playButtonNotifier,
        builder: (_, value, __) {
          switch (value) {
            case ButtonState.playing:
              return IconButton(
                icon: const Icon(Icons.pause),
                onPressed: () {
                  _audioHelper.pause();
                },
                color: InheritedProperties.of(context)
                    .theme
                    .sentMessageTextStyle
                    .color,
              );
            case ButtonState.paused:
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                color: InheritedProperties.of(context)
                    .theme
                    .sentMessageTextStyle
                    .color,
                onPressed: () {
                  _audioHelper.play();
                },
              );
            case ButtonState.loading:
              return const CircularProgressIndicator(
                value: 10,
              );
            default:
              return IconButton(
                icon: const Icon(Icons.pause),
                onPressed: () async {},
              );
          }
        });
  }

  Widget progressBar() {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: _audioHelper.progressNotifier,
      builder: (_, value, __) {
        // logger.log("value : ${value.current.inSeconds as double}");
        // logger.log("max : ${widget.message.size as double}");
        // logger.log("min: 0.00");
        // return SizedBox(
        //   child: Slider(
        //       min: 0.00,
        //       value: value.current.inSeconds.round() as double,
        //       max: widget.message.size.round() as double,
        //       onChanged: (a) {}),
        // );

        return ProgressBar(
            progress: value.current, total: const Duration(seconds: 10));
      },
    );
  }
}
