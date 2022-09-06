import 'package:flutter/material.dart';

abstract class ChatTheme {
  final Color sentMessageBubbleColor;
  final Color receivedMessageBubbleColor;
  final TextStyle sentMessageTextStyle;
  final TextStyle receivedMessageTextStyle;
  final TextStyle? sentMessageBoldTextStyle;
  final TextStyle? receivedMessageBoldTextStyle;
  final TextStyle placeholderTextStyle;
  final EdgeInsets messagePadding;
  final TextStyle? tagMessageTextStyle;
  final TextStyle dateHeaderTextStyle;
  final Color? referencedMessageBackgroundColor;
  final Color chatBackGroundColor;
  final Color? messageInputColor;
  final TextStyle? linkPreviewTitleTextStyle;
  final TextStyle? sentMessageBodyCodeTextStyle;
  final TextStyle? receivedMessageBodyCodeTextStyle;
  final TextStyle sentTimeTextStyle;
  final TextStyle receivedTimeTextStyle;
  final TextStyle headlineTextStyle;
  final TextStyle secondaryHeadlineTextStyle;
  final TextStyle labelTextStyle;
  final TextStyle subtitleTextStyle;
  final TextStyle captionTextStyle;
  final TextStyle systemMessageTextStyle;

  const ChatTheme({
    required this.systemMessageTextStyle,
    required this.chatBackGroundColor,
    required this.sentMessageBubbleColor,
    required this.receivedMessageBubbleColor,
    required this.sentMessageTextStyle,
    required this.receivedMessageTextStyle,
    required this.sentMessageBoldTextStyle,
    required this.placeholderTextStyle,
    required this.messagePadding,
    required this.dateHeaderTextStyle,
    required this.sentTimeTextStyle,
    required this.receivedTimeTextStyle,
    required this.headlineTextStyle,
    required this.secondaryHeadlineTextStyle,
    required this.labelTextStyle,
    required this.subtitleTextStyle,
    required this.captionTextStyle,
    this.tagMessageTextStyle,
    this.messageInputColor,
    this.referencedMessageBackgroundColor,
    this.receivedMessageBoldTextStyle,
    this.linkPreviewTitleTextStyle,
    this.receivedMessageBodyCodeTextStyle,
    this.sentMessageBodyCodeTextStyle,
  });
}
