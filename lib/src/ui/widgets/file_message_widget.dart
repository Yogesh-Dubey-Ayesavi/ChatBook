part of '../../../chatbook.dart';

class FileMessageWidget extends StatefulWidget {
  const FileMessageWidget({Key? key, required this.message}) : super(key: key);
  final FileMessage message;

  @override
  State<FileMessageWidget> createState() => _FileMessageWidgetState();
}

class _FileMessageWidgetState extends State<FileMessageWidget> {
  
  late MediaStateHelper _mediaStateHelper = MediaStateHelper();

  @override
  void initState() {
    super.initState();
  }

  //  _fileSizeProvider() {

  // }

  void onTapFile(String mediaUrl) {
    if (kIsWeb) {
      launchUrl(Uri.parse(mediaUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTapFile(widget.message.uri);
      },
      title: Text(widget.message.name,
          style: InheritedProperties.of(context).theme.labelTextStyle),
      leading: SizedBox(
        height: 50,
        child: Stack(alignment: Alignment.center, children: const [
          CircleAvatar(
              radius: 20,
              backgroundColor: Color(0XFF191919),
              child: Icon(
                CupertinoIcons.doc,
              )),
          CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
        ]),
      ),
      subtitle: Text(
        getFileSize(widget.message.size as int, 2),
        style: InheritedProperties.of(context).theme.subtitleTextStyle,
      ),
    );
  }
}
