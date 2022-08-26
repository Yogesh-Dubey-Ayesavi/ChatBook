// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gif_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GifMessage _$GifMessageFromJson(Map<String, dynamic> json) => GifMessage(
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
      gif: GiphyGif.fromJson(json['gif'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] as int?,
    );

Map<String, dynamic> _$GifMessageToJson(GifMessage instance) =>
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
      'updatedAt': instance.updatedAt,
      'self': instance.self,
      'previewData': instance.previewData,
      'gif': instance.gif,
    };

const _$StatusEnumMap = {
  Status.delivered: 'delivered',
  Status.error: 'error',
  Status.seen: 'seen',
  Status.sending: 'sending',
  Status.sent: 'sent',
};
