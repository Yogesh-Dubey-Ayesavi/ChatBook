part of '../../../chatbook.dart';

class TextMessageWidget extends StatefulWidget {
  const TextMessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  final TextMessage message;
  @override
  State<TextMessageWidget> createState() => _TextMessageWidgetState();
}

class _TextMessageWidgetState extends State<TextMessageWidget> {



  @override
  Widget build(BuildContext context) {


    final bodyTextStyle = widget.message.self == true ?
              InheritedChatTheme.of(context).theme.sentMessageTextStyle : InheritedChatTheme.of(context).theme.receivedMessageTextStyle;

    final boldTextStyle = widget.message.self == true ?
              InheritedChatTheme.of(context).theme.sentMessageBoldTextStyle : InheritedChatTheme.of(context).theme.receivedMessageBoldTextStyle;

    final codeTextStyle = widget.message.self == true?
              InheritedChatTheme.of(context).theme.sentMessageBodyCodeTextStyle:InheritedChatTheme.of(context).theme.receivedMessageBodyCodeTextStyle;

    RegExp exp =  RegExp(r'(?:(?:https?|ftp):)?[\w/\-?=%.]+\.[\w/\-?=%.]+');

   String?  _urlGiver(String text){
      String? urlText;
      Iterable<RegExpMatch> matches = exp.allMatches(text);
      for (var match in matches) {
        urlText = (text.substring(match.start, match.end));
      }
      return urlText;
    }

    _urlGiver(widget.message.text);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(_urlGiver(widget.message.text) != null)
                AnyLinkPreview.builder(
                  placeholderWidget: const SizedBox(height: 0,width: 0,),
                    errorWidget: const SizedBox(height: 0,width: 0,),
                    link: _urlGiver(widget.message.text)!,
                    itemBuilder: (_,metadata,image){
                      return GestureDetector(
                        onTap: (){
                             if(metadata.url != null){
                               launchUrl(Uri.parse(metadata.url!));
                             }
                        },
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          margin: EdgeInsets.zero,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                           if (image!=null) ...  [
                             ClipRRect(
                               borderRadius: const BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5)),
                               child: Image(image: image),
                             ),
                              ],
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(metadata.title!,style: const TextStyle(fontWeight: FontWeight.bold),),
                                    if (metadata.desc!= null && metadata.desc != '' && metadata.desc!='A new Flutter project.')...[
                                          const SizedBox(height: 10),
                                          Text(metadata.desc!)
                                    ]
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ParsedText(
              selectable: true,
              text: widget.message.text,
              style: bodyTextStyle,
              parse: [
                MatchText(
                  onTap: (mail) async {
                    final url = Uri(scheme: 'mailto', path: mail);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  pattern: r'([a-zA-Z0-9+._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)',
                  style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                ),
                MatchText(
                  onTap: (urlText) async {
                    final protocolIdentifierRegex = exp;
                    if (!urlText.startsWith(protocolIdentifierRegex)) {
                      urlText = 'https://$urlText';
                    }
                    {
                      final url = Uri.tryParse(urlText);
                      if (url != null && await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    }
                  },
                  pattern: r'((http|ftp|https):\/\/)?([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?',
                  style:const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                ),

                MatchText(
                  pattern: PatternStyle.bold.pattern,
                  style: boldTextStyle ??
                      bodyTextStyle.merge(PatternStyle.bold.textStyle),
                  renderText: ({required String str, required String pattern}) =>
                  {
                    'display': str.replaceAll(
                      PatternStyle.bold.from,
                      PatternStyle.bold.replace,
                    ),
                  },
                ),
                MatchText(
                  pattern: PatternStyle.italic.pattern,
                  style: bodyTextStyle.merge(PatternStyle.italic.textStyle),
                  renderText: ({required String str, required String pattern}) =>
                  {
                    'display': str.replaceAll(
                      PatternStyle.italic.from,
                      PatternStyle.italic.replace,
                    ),
                  },
                ),
                MatchText(
                  pattern: PatternStyle.lineThrough.pattern,
                  style: bodyTextStyle.merge(PatternStyle.lineThrough.textStyle),
                  renderText: ({required String str, required String pattern}) =>
                  {
                    'display': str.replaceAll(
                      PatternStyle.lineThrough.from,
                      PatternStyle.lineThrough.replace,
                    ),
                  },
                ),
                MatchText(
                  pattern: PatternStyle.code.pattern,
                  style: codeTextStyle ??
                      bodyTextStyle.merge(PatternStyle.code.textStyle),
                  renderText: ({required String str, required String pattern}) =>
                  {
                    'display': str.replaceAll(
                      PatternStyle.code.from,
                      PatternStyle.code.replace,
                    ),
                  },
                ),
                MatchText(
                  pattern: PatternStyle.at.pattern,
                  style: codeTextStyle ??
                      bodyTextStyle.merge(PatternStyle.at.textStyle),
                  renderText: ({required String str, required String pattern}) =>
                  {
                    'display': str.replaceAll(
                      PatternStyle.code.from,
                      PatternStyle.code.replace,
                    ),
                  },
                ),



              ],

            )

            // SelectableLinkify(text: widget.message.text,onOpen: (element){
            //   _launchInBrowser(Uri.parse(element.url));
            // },),
          ),


        ],
    ) ;
  }






}

