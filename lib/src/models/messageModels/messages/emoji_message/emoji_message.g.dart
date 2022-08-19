// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emoji_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmojiMessage _$EmojiMessageFromJson(Map<String, dynamic> json) => EmojiMessage(
      author: User.fromJson(json['author'] as Map<String, dynamic>),
      self: json['self'] as bool?,
      createdAt: json['createdAt'] as int?,
      id: json['id'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
      previewData: json['previewData'] == null
          ? null
          : PreviewData.fromJson(json['previewData'] as Map<String, dynamic>),
      remoteId: json['remoteId'] as String?,
      repliedMessage: json['repliedMessage'] == null
          ? null
          : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
      roomId: json['roomId'] as String?,
      showStatus: json['showStatus'] as bool?,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
      emoji: json['emoji'] as String,
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
      updatedAt: json['updatedAt'] as int?,
    );

Map<String, dynamic> _$EmojiMessageToJson(EmojiMessage instance) =>
    <String, dynamic>{
      'author': instance.author,
      'createdAt': instance.createdAt,
      'id': instance.id,
      'metadata': instance.metadata,
      'remoteId': instance.remoteId,
      'repliedMessage': instance.repliedMessage,
      'roomId': instance.roomId,
      'showStatus': instance.showStatus,
      'status': _$StatusEnumMap[instance.status],
      'type': _$MessageTypeEnumMap[instance.type]!,
      'updatedAt': instance.updatedAt,
      'self': instance.self,
      'previewData': instance.previewData,
      'emoji': instance.emoji,
    };

const _$StatusEnumMap = {
  Status.delivered: 'delivered',
  Status.error: 'error',
  Status.seen: 'seen',
  Status.sending: 'sending',
  Status.sent: 'sent',
};

const _$MessageTypeEnumMap = {
  MessageType.custom: 'custom',
  MessageType.file: 'file',
  MessageType.image: 'image',
  MessageType.system: 'system',
  MessageType.text: 'text',
  MessageType.unsupported: 'unsupported',
  MessageType.audio: 'audio',
  MessageType.video: 'video',
  MessageType.emoji: 'emoji',
  MessageType.gif: 'gif',
  MessageType.location: 'location',
};
