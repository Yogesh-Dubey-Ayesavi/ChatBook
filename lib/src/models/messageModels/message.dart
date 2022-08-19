import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'messages/custom_message/custom_message.dart';
import 'messages/file_message/file_message.dart';
import 'messages/audio_message/audio_message.dart';
import 'messages/video_message/video_message.dart';
import 'messages/emoji_message/emoji_message.dart';
import 'messages/image_message/image_message.dart';
import 'messages/gif_message/gif_message.dart';
import 'messages/system_message/system_message.dart';
import 'messages/text_message/text_message.dart';
import 'messages/unsupported_message.dart';
import 'user.dart' show User;

/// All possible message types.
enum MessageType { custom, file, image, system, text, unsupported, audio, video, emoji, gif,location }

/// All possible statuses message can have.
enum Status { delivered, error, seen, sending, sent }

/// An abstract class that contains all variables and methods
/// every message will have.
@immutable
abstract class Message extends Equatable {
  const Message( {
    required this.author,
    this.createdAt,
    required this.id,
    this.metadata,
    this.self,
    this.remoteId,
    this.repliedMessage,
    this.roomId,
    this.showStatus,
    this.status,
    required this.type,
    this.updatedAt,
  });

  /// Creates a particular message from a map (decoded JSON).
  /// Type is determined by the `type` field.
  factory Message.fromJson(Map<String, dynamic> json) {
    final type = MessageType.values.firstWhere(
      (e) => e.name == json['type'],
      orElse: () => MessageType.unsupported,
    );

    switch (type) {
      case MessageType.custom:
        return CustomMessage.fromJson(json);
      case MessageType.file:
        return FileMessage.fromJson(json);
      case MessageType.audio:
        return AudioMessage.fromJson(json);
      case MessageType.video:
        return VideoMessage.fromJson(json);
      case MessageType.emoji:
        return EmojiMessage.fromJson(json);
      case MessageType.image:
        return ImageMessage.fromJson(json);
      case MessageType.system:
        return SystemMessage.fromJson(json);
      case MessageType.text:
        return TextMessage.fromJson(json);
      case MessageType.gif:
        return GifMessage.fromJson(json);
      default:
        return UnsupportedMessage.fromJson(json);
    }
  }

  /// User who sent this message.
  final User author;

  /// Created message timestamp, in ms.
  final int? createdAt;

  /// Unique ID of the message.
  final String id;

  /// Additional custom metadata or attributes related to the message.
  final Map<String, dynamic>? metadata;

  /// Unique ID of the message received from the backend.
  final String? remoteId;

  /// Message that is being replied to with the current message.
  final Message? repliedMessage;

  /// ID of the room where this message is sent.
  final String? roomId;

  /// Show status or not.
  final bool? showStatus;

  /// Message [Status].
  final Status? status;

  /// [MessageType].
  final MessageType type;

  /// Updated message timestamp, in ms.
  final int? updatedAt;

  /// Specifies whether a message belongs to current user or not
  /// if not no need to mention
  final bool?self;


  /// Creates a copy of the message with an updated data.
  Message copyWith({
    User? author,
    int? createdAt,
    String? id,
    bool? self,
    Map<String, dynamic>? metadata,
    String? remoteId,
    Message? repliedMessage,
    String? roomId,
    bool? showStatus,
    Status? status,
    int? updatedAt,
  });

  /// Converts a particular message to the map representation, serializable to JSON.
  Map<String, dynamic> toJson();
}
