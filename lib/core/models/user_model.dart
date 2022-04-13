import 'package:ketabna/core/models/intersts_model.dart';

class UserModel {
  String? phone;
  String? name;
  String? email;
  String? location;
  InterstsModel? interstsModel;
  bool? isWhatsApp;
  UserModel(
      {required this.email,
      required this.name,
      required this.phone,
      required this.location,
      required this.interstsModel,
      required this.isWhatsApp});
  UserModel.fromJson(Map<String, dynamic> map) {
    email = map['email'];
    phone = map['phone'];
    name = map['name'];
    location = map['location'];
    interstsModel = InterstsModel.fromMap(map['interstsModel']);
    isWhatsApp = map['isWhatsApp'];
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'location': location,
      'isWhatsApp': isWhatsApp,
      'interstsModel': interstsModel!.toMap(),
    };
  }
}
