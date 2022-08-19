// import 'dart:html';
//
// import 'package:json_annotation/json_annotation.dart';
// import 'package:meta/meta.dart';
//
// import '../message.dart';
// import '../preview_data.dart' show PreviewData;
// import '../user.dart' show User;
//
// part 'location_message.g.dart';
//
// /// A class that represents location message.
// @JsonSerializable()
// @immutable
// abstract class LocationMessage extends Message {
//   /// Creates a location message.
//   const LocationMessage._({
//     required super.author,
//     super.self,
//     super.createdAt,
//     required super.id,
//     super.metadata,
//     this.previewData,
//     super.remoteId,
//     super.repliedMessage,
//     super.roomId,
//     super.showStatus,
//     super.status,
//     required this.location,
//     MessageType? type,
//     super.updatedAt,
//   }) : super(type: type ?? MessageType.location);
//
//   const factory LocationMessage({
//     required User author,
//     bool?self,
//     int? createdAt,
//     required String id,
//     Map<String, dynamic>? metadata,
//     PreviewData? previewData,
//     String? remoteId,
//     Message? repliedMessage,
//     String? roomId,
//     bool? showStatus,
//     Status? status,
//     required LatLng location,
//     MessageType? type,
//     int? updatedAt,
//   }) = _LocationMessage;
//
//   /// Creates a location message from a map (decoded JSON).
//   factory LocationMessage.fromJson(Map<String, dynamic> json) =>
//       _$LocationMessageFromJson(json);
//
//
//
//   /// See [PreviewData].
//   final PreviewData? previewData;
//
//   /// User's message.
//   final LatLng location;
//
//   /// Equatable props.
//   @override
//   List<Object?> get props => [
//     author,
//     createdAt,
//     id,
//     metadata,
//     previewData,
//     remoteId,
//     repliedMessage,
//     roomId,
//     status,
//     location,
//     updatedAt,
//   ];
//
//   @override
//   Message copyWith({
//     User? author,
//     bool?self,
//     int? createdAt,
//     String? id,
//     Map<String, dynamic>? metadata,
//     PreviewData? previewData,
//     String? remoteId,
//     Message? repliedMessage,
//     String? roomId,
//     bool? showStatus,
//     Status? status,
//     LatLng? location,
//     int? updatedAt,
//   });
//
//   /// Converts a location message to the map representation, encodable to JSON.
//   @override
//   Map<String, dynamic> toJson() => _$LocationMessageToJson(this);
// }
//
// /// A utility class to enable better copyWith.
// class _LocationMessage extends LocationMessage {
//   const _LocationMessage({
//     required super.author,
//     super.createdAt,
//     super.self,
//     required super.id,
//     super.metadata,
//     super.previewData,
//     super.remoteId,
//     super.repliedMessage,
//     super.roomId,
//     super.showStatus,
//     super.status,
//     required super.location,
//     super.type,
//     super.updatedAt,
//   }) : super._();
//
//   @override
//   Message copyWith({
//     User? author,
//     bool?self,
//     dynamic createdAt = _Unset,
//     String? id,
//     dynamic metadata = _Unset,
//     dynamic previewData = _Unset,
//     dynamic remoteId = _Unset,
//     dynamic repliedMessage = _Unset,
//     dynamic roomId,
//     dynamic showStatus = _Unset,
//     dynamic status = _Unset,
//     LatLng? location,
//     dynamic updatedAt = _Unset,
//   }) =>
//       _LocationMessage(
//         author: author ?? this.author,
//         createdAt: createdAt == _Unset ? this.createdAt : createdAt as int?,
//         id: id ?? this.id,
//         metadata: metadata == _Unset
//             ? this.metadata
//             : metadata as Map<String, dynamic>?,
//         previewData: previewData == _Unset
//             ? this.previewData
//             : previewData as PreviewData?,
//         remoteId: remoteId == _Unset ? this.remoteId : remoteId as String?,
//         repliedMessage: repliedMessage == _Unset
//             ? this.repliedMessage
//             : repliedMessage as Message?,
//         roomId: roomId == _Unset ? this.roomId : roomId as String?,
//         showStatus:
//         showStatus == _Unset ? this.showStatus : showStatus as bool?,
//         self:
//         self == _Unset ? this.self : self as bool?,
//         status: status == _Unset ? this.status : status as Status?,
//         location: location ?? this.location,
//         updatedAt: updatedAt == _Unset ? this.updatedAt : updatedAt as int?,
//       );
// }
//
// class _Unset {}
