import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userEmail;
  final int userId;
  final String userImage;
  final String userName;
  final String userPassword;
  final String userPhone;
  final String userType;
  final String userVideo;

  UserModel({
    required this.userEmail,
    required this.userId,
    required this.userImage,
    required this.userName,
    required this.userPassword,
    required this.userPhone,
    required this.userType,
    required this.userVideo,
  });

  factory UserModel.fromJson(DocumentSnapshot json) => UserModel(
        userEmail: json["user_email"] ?? "",
        userId: json["user_id"] ?? 0,
        userImage: json["user_image"] ?? "",
        userName: json["user_name"] ?? "",
        userPassword: json["user_password"] ?? "",
        userPhone: json["user_phone"] ?? "",
        userType: json["user_type"] ?? "",
        userVideo: json["user_video"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user_email": userEmail,
        "user_id": userId,
        "user_image": userImage,
        "user_name": userName,
        "user_password": userPassword,
        "user_phone": userPhone,
        "user_type": userType,
        "user_video": userVideo,
      };

  static List<UserModel> jsonToList(List<DocumentSnapshot> json) =>
      List<UserModel>.from(json.map((x) => UserModel.fromJson(x)).toList());

}
