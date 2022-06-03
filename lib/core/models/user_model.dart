import 'package:ketabna/core/models/intersts_model.dart';

class UserModel {
  String? phone;
  String? name;
  String? email;
  String? location;
  InterstsModel? interstsModel;
  String? picture;
  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.location,
    required this.interstsModel,
    required this.picture,
  });
  UserModel.fromJson(Map<String, dynamic> map) {
    email = map['email'];
    phone = map['phone'];
    name = map['name'];
    location = map['location'];
    picture = map['picture'];
    interstsModel = InterstsModel.fromMap(map['interstsModel']);
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'location': location,
      'picture': picture,
      'interstsModel': interstsModel!.toMap(),
    };
  }
}
