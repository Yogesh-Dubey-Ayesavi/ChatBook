import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

class DefaultChatTheme extends ChatTheme {
  const DefaultChatTheme(
      {super.tagMessageTextStyle = const TextStyle(color: Colors.white),
      super.messageInputColor = const Color(0XFF191919),
      super.receivedMessageBodyCodeTextStyle,
      super.sentMessageBodyCodeTextStyle,
      super.sentTimeTextStyle =
          const TextStyle(color: Colors.grey, fontSize: 10),
      super.receivedTimeTextStyle =
          const TextStyle(color: Colors.black, fontSize: 12),
      super.sentMessageBubbleColor = const Color(0XFF005FFF),
      super.receivedMessageBubbleColor =
          const Color.fromRGBO(255, 255, 255, .87),
      super.sentMessageTextStyle =
          const TextStyle(color: Colors.white, fontSize: 14),
      super.receivedMessageTextStyle =
          const TextStyle(color: Colors.black, fontSize: 14),
      super.sentMessageBoldTextStyle,
      super.placeholderTextStyle =
          const TextStyle(color: Colors.black, fontSize: 14),
      super.messagePadding = const EdgeInsets.all(10),
      super.dateHeaderTextStyle =
          const TextStyle(color: Colors.grey, fontSize: 14),
      super.referencedMessageBackgroundColor,
      super.receivedMessageBoldTextStyle,
      super.chatBackGroundColor = const Color(0XFF010101),
      super.linkPreviewTitleTextStyle = const TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800)});
}
