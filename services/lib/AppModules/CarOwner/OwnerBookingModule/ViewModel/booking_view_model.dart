

import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String serviceId;
  final String serviceName;
  final String serviceEmail;
  final String servicePhone;
  final String serviceImage;
  final String serviceVideo;
  final String ownerId;
  final String ownerName;
  final String ownerEmail;
  final String ownerPhone;
  final String ownerImage;
  final String ownerVideo;
  final String serviceSelect;
  final String servicePrice;
  final String serviceDesc;
  final DateTime date;
  final DateTime time;
  final String nowTime;
  final String status;

  BookingModel({
    required this.serviceId,
    required this.serviceName,
    required this.serviceEmail,
    required this.servicePhone,
    required this.serviceImage,
    required this.serviceVideo,
    required this.ownerId,
    required this.ownerName,
    required this.ownerEmail,
    required this.ownerPhone,
    required this.ownerImage,
    required this.ownerVideo,
    required this.serviceSelect,
    required this.servicePrice,
    required this.serviceDesc,
    required this.date,
    required this.time,
    required this.nowTime,
    required this.status,
  });
// Map<String, dynamic>
  factory BookingModel.fromJson(DocumentSnapshot json) => BookingModel(
        serviceId: json["service_id"].toString(),
        serviceName: json["service_name"].toString(),
        serviceEmail: json["service_email"].toString(),
        servicePhone: json["service_phone"].toString(),
        serviceImage: json["service_image"].toString(),
        serviceVideo: json["service_video"].toString(),
        ownerId: json["owner_id"].toString(),
        ownerName: json["owner_name"].toString(),
        ownerEmail: json["owner_email"].toString(),
        ownerPhone: json["owner_phone"].toString(),
        ownerImage: json["owner_image"].toString(),
        ownerVideo: json["owner_video"].toString(),
        serviceSelect: json["service_select"].toString(),
        servicePrice: json["service_price"].toString(),
        serviceDesc: json["service_desc"].toString(),
        date: DateTime.parse(json["date"].toString()),
        time: DateTime.parse(json["time"].toString()),
        nowTime: json["now_time"].toString(),
        status: json["status"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "service_id": serviceId,
        "service_name": serviceName,
        "service_email": serviceEmail,
        "service_phone": servicePhone,
        "service_image": serviceImage,
        "service_video": serviceVideo,
        "owner_id": ownerId,
        "owner_name": ownerName,
        "owner_email": ownerEmail,
        "owner_phone": ownerPhone,
        "owner_image": ownerImage,
        "owner_video": ownerVideo,
        "service_select": serviceSelect,
        "service_price": servicePrice,
        "service_desc": serviceDesc,
        "date": date,
        "time": time,
        "now_time": nowTime,
        "status": status,
      };

  static List<BookingModel> jsonToList(List<DocumentSnapshot> json) =>
      List<BookingModel>.from(json.map((x) => BookingModel.fromJson(x)).toList());
}