part of '../../../chatbook.dart';

class ImageMessageWidget extends StatefulWidget {
  const ImageMessageWidget({Key? key, required this.message}) : super(key: key);

  final ImageMessage message;

  @override
  State<ImageMessageWidget> createState() => _ImageMessageWidgetState();
}

class _ImageMessageWidgetState extends State<ImageMessageWidget> {
  Widget? _imageProvider(String url) {
    if (Uri.parse(url).isAbsolute) {
      return Image(
        image: NetworkImage(url),
      );
    } else if (Platform.isAndroid || Platform.isIOS) {
      print('Image For Android || Image for Ios');
      return Image(image: FileImage(File(url)));
    }
    return null;
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // setState() {
              //   _isLoading = true;
              // }
            },
            child: _imageProvider(widget.message.uri),
          ),
          if (_isLoading) ...[
            const RepaintBoundary(
                child: CupertinoActivityIndicator(
              radius: 20,
            ))
          ]
        ],
      ),
    );
  }
}
