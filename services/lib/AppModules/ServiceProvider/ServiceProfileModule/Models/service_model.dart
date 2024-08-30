import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  final String service_name;
  final String service_price;
  final String service_desc;

  ServiceModel({
    required this.service_name,
    required this.service_price,
    required this.service_desc,
  });

  factory ServiceModel.fromJson(DocumentSnapshot json) => ServiceModel(
    service_name: json["service_name"] ?? "",
    service_price: json["service_price"] ?? "",
    service_desc: json["service_desc"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "service_name": service_name,
    "service_price": service_price,
    "service_desc": service_desc,
  };

  static List<ServiceModel> jsonToList(List<DocumentSnapshot> json) =>
      List<ServiceModel>.from(json.map((x) => ServiceModel.fromJson(x)).toList());

}
