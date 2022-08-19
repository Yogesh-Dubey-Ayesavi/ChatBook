// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartialVideo _$PartialVideoFromJson(Map<String, dynamic> json) => PartialVideo(
      metadata: json['metadata'] as Map<String, dynamic>?,
      mimeType: json['mimeType'] as String?,
      name: json['name'] as String,
      repliedMessage: json['repliedMessage'] == null
          ? null
          : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
      size: json['size'] as num,
      uri: json['uri'] as String,
    );

Map<String, dynamic> _$PartialVideoToJson(PartialVideo instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'mimeType': instance.mimeType,
      'name': instance.name,
      'repliedMessage': instance.repliedMessage,
      'size': instance.size,
      'uri': instance.uri,
    };
