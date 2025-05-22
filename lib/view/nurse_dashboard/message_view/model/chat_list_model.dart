class ChatListModel {
  ChatListModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final List<Data>? data;

  factory ChatListModel.fromJson(Map<String, dynamic> json){
    return ChatListModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.unseenMessageCount,
  });

  final String? id;
  final List<Participant> participants;
  final LastMessage? lastMessage;
  final int? unseenMessageCount;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
      lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
      unseenMessageCount: json["unseenMessageCount"],
    );
  }

}

class LastMessage {
  LastMessage({
    required this.id,
    required this.senderId,
    required this.chatId,
    required this.content,
    required this.files,
    required this.notification,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? senderId;
  final String? chatId;
  final String? content;
  final List<dynamic> files;
  final dynamic notification;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory LastMessage.fromJson(Map<String, dynamic> json){
    return LastMessage(
      id: json["id"],
      senderId: json["senderId"],
      chatId: json["chatId"],
      content: json["content"],
      files: json["files"] == null ? [] : List<dynamic>.from(json["files"]!.map((x) => x)),
      notification: json["notification"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}

class Participant {
  Participant({
    required this.id,
    required this.userId,
    required this.profilePicture,
    required this.fullname,
  });

  final String? id;
  final String? userId;
  final String? profilePicture;
  final String? fullname;

  factory Participant.fromJson(Map<String, dynamic> json){
    return Participant(
      id: json["id"],
      userId: json["userId"],
      profilePicture: json["profilePicture"],
      fullname: json["fullname"],
    );
  }

}
