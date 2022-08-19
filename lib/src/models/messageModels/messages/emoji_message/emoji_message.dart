import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../message.dart';

import '../../preview_data.dart' show PreviewData;
import '../../user.dart' show User;

part 'emoji_message.g.dart';

/// A class that represents emoji message.
@JsonSerializable()
@immutable
abstract class EmojiMessage extends Message {
  /// Creates a emoji message.
  const EmojiMessage._({
    required super.author,
    super.self,
    super.createdAt,
    required super.id,
    super.metadata,
    this.previewData,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    required this.emoji,
    MessageType? type,
    super.updatedAt,
  }) : super(type: type ?? MessageType.emoji);

  const factory EmojiMessage({
    required User author,
    bool?self,
    int? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    Status? status,
    required String emoji,
    MessageType? type,
    int? updatedAt,
  }) = _EmojiMessage;

  /// Creates a emoji message from a map (decoded JSON).
  factory EmojiMessage.fromJson(Map<String, dynamic> json) =>
      _$EmojiMessageFromJson(json);



  /// See [PreviewData].
  final PreviewData? previewData;

  /// User's message.
  final String emoji;

  /// Equatable props.
  @override
  List<Object?> get props => [
    author,
    createdAt,
    id,
    metadata,
    previewData,
    remoteId,
    repliedMessage,
    roomId,
    status,
    emoji,
    updatedAt,
  ];

  @override
  Message copyWith({
    User? author,
    bool?self,
    int? createdAt,
    String? id,
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    Status? status,
    String? emoji,
    int? updatedAt,
  });

  /// Converts a emoji message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$EmojiMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _EmojiMessage extends EmojiMessage {
  const _EmojiMessage({
    required super.author,
    super.createdAt,
    super.self,
    required super.id,
    super.metadata,
    super.previewData,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    super.status,
    required super.emoji,
    super.type,
    super.updatedAt,
  }) : super._();

  @override
  Message copyWith({
    User? author,
    bool?self,
    dynamic createdAt = _Unset,
    String? id,
    dynamic metadata = _Unset,
    dynamic previewData = _Unset,
    dynamic remoteId = _Unset,
    dynamic repliedMessage = _Unset,
    dynamic roomId,
    dynamic showStatus = _Unset,
    dynamic status = _Unset,
    String? emoji,
    dynamic updatedAt = _Unset,
  }) =>
      _EmojiMessage(
        author: author ?? this.author,
        createdAt: createdAt == _Unset ? this.createdAt : createdAt as int?,
        id: id ?? this.id,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        previewData: previewData == _Unset
            ? this.previewData
            : previewData as PreviewData?,
        remoteId: remoteId == _Unset ? this.remoteId : remoteId as String?,
        repliedMessage: repliedMessage == _Unset
            ? this.repliedMessage
            : repliedMessage as Message?,
        roomId: roomId == _Unset ? this.roomId : roomId as String?,
        showStatus:
        showStatus == _Unset ? this.showStatus : showStatus as bool?,
        self:
        self == _Unset ? this.self : self as bool?,
        status: status == _Unset ? this.status : status as Status?,
        emoji: emoji ?? this.emoji,
        updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as int?,
      );
}

class _Unset {}
