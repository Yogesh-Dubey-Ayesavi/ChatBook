import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../message.dart';
import '../../user.dart' show User;
import 'partial_audio.dart';

part 'audio_message.g.dart';

/// A class that represents file message.
@JsonSerializable()
@immutable
abstract class AudioMessage extends Message {
  /// Creates a file message.
  const AudioMessage._({
    required super.author,
    super.self,
    super.createdAt,
    required super.id,
    this.isLoading,
    super.metadata,
    this.mimeType,
    required this.name,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    required this.size,
    super.status,
    MessageType? type,
    super.updatedAt,
    required this.uri,
  }) : super(type: type ?? MessageType.audio);

  const factory AudioMessage({
    required User author,
    int? createdAt,
    bool?self,
    required String id,
    bool? isLoading,
    Map<String, dynamic>? metadata,
    String? mimeType,
    required String name,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    required num size,
    Status? status,
    MessageType? type,
    int? updatedAt,
    required String uri,
  }) = _AudioMessage;

  /// Creates a file message from a map (decoded JSON).
  factory AudioMessage.fromJson(Map<String, dynamic> json) =>
      _$AudioMessageFromJson(json);

  /// Creates a full file message from a partial one.
  factory AudioMessage.fromPartial({
    required User author,
    bool?self,
    int? createdAt,
    required String id,
    bool? isLoading,
    required PartialAudio partialAudio,
    String? remoteId,
    String? roomId,
    bool? showStatus,
    Status? status,
    int? updatedAt,
  }) =>
      _AudioMessage(
        author: author,
        createdAt: createdAt,
        id: id,
        self: self,
        isLoading: isLoading,
        metadata: partialAudio.metadata,
        mimeType: partialAudio.mimeType,
        name: partialAudio.name,
        remoteId: remoteId,
        repliedMessage: partialAudio.repliedMessage,
        roomId: roomId,
        showStatus: showStatus,
        size: partialAudio.size,
        status: status,
        type: MessageType.audio,
        updatedAt: updatedAt,
        uri: partialAudio.uri,
      );

  /// Specify whether the message content is currently being loaded.
  final bool? isLoading;

  /// Media type.
  final String? mimeType;

  /// The name of the file.
  final String name;

  /// Size of the file in bytes.
  final num size;

  /// The file source (either a remote URL or a local resource).
  final String uri;

  /// Equatable props.
  @override
  List<Object?> get props => [
    author,
    createdAt,
    id,
    isLoading,
    metadata,
    mimeType,
    name,
    remoteId,
    repliedMessage,
    roomId,
    size,
    status,
    updatedAt,
    uri,
  ];

  @override
  Message copyWith({
    User? author,
    int? createdAt,
    bool?self,
    String? id,
    bool? isLoading,
    Map<String, dynamic>? metadata,
    String? mimeType,
    String? name,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    num? size,
    Status? status,
    int? updatedAt,
    String? uri,
  });

  /// Converts a file message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$AudioMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _AudioMessage extends AudioMessage {
  const _AudioMessage({
    required super.author,
    super.self,
    super.createdAt,
    required super.id,
    super.isLoading,
    super.metadata,
    super.mimeType,
    required super.name,
    super.remoteId,
    super.repliedMessage,
    super.roomId,
    super.showStatus,
    required super.size,
    super.status,
    super.type,
    super.updatedAt,
    required super.uri,
  }) : super._();

  @override
  Message copyWith({
    User? author,
    bool?self,
    dynamic createdAt = _Unset,
    dynamic height = _Unset,
    String? id,
    dynamic isLoading = _Unset,
    dynamic metadata = _Unset,
    dynamic mimeType = _Unset,
    String? name,
    dynamic remoteId = _Unset,
    dynamic repliedMessage = _Unset,
    dynamic roomId,
    dynamic showStatus = _Unset,
    num? size,
    dynamic status = _Unset,
    dynamic updatedAt = _Unset,
    String? uri,
    dynamic width = _Unset,
  }) =>
      _AudioMessage(
        author: author ?? this.author,
        createdAt: createdAt == _Unset ? this.createdAt : createdAt as int?,
        id: id ?? this.id,
        isLoading: isLoading == _Unset ? this.isLoading : isLoading as bool?,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        mimeType: mimeType == _Unset ? this.mimeType : mimeType as String?,
        name: name ?? this.name,
        remoteId: remoteId == _Unset ? this.remoteId : remoteId as String?,
        repliedMessage: repliedMessage == _Unset
            ? this.repliedMessage
            : repliedMessage as Message?,
        roomId: roomId == _Unset ? this.roomId : roomId as String?,
        showStatus:
        showStatus == _Unset ? this.showStatus : showStatus as bool?,
        self:
        self == _Unset ? this.self : self as bool?,
        size: size ?? this.size,
        status: status == _Unset ? this.status : status as Status?,
        updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as int?,
        uri: uri ?? this.uri,
      );
}

class _Unset {}
