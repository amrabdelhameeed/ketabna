import 'package:ketabna/core/models/intersts_model.dart';

class UserModel {
  String? phone;
  String? name;
  String? email;
  String? location;
  InterstsModel? interstsModel;
<<<<<<< HEAD
  bool? isWhatsApp;
  bool? isSemesterPaid;
=======
  String? picture;
  String? userUid;
>>>>>>> d425cdc95f41d99c525d988e9700634c20036c31
  UserModel(
      {required this.email,
      required this.name,
      required this.phone,
      required this.location,
      required this.interstsModel,
<<<<<<< HEAD
      required this.isWhatsApp,
      required this.isSemesterPaid,
      });

=======
      required this.picture,
      required this.userUid});
>>>>>>> d425cdc95f41d99c525d988e9700634c20036c31
  UserModel.fromJson(Map<String, dynamic> map) {
    email = map['email'];
    phone = map['phone'];
    name = map['name'];
    location = map['location'];
    picture = map['picture'];
    userUid = map['userUid'];

    interstsModel = InterstsModel.fromMap(map['interstsModel']);
<<<<<<< HEAD
    isWhatsApp = map['isWhatsApp'];
    isSemesterPaid = map['isSemesterPaid'];
=======
>>>>>>> d425cdc95f41d99c525d988e9700634c20036c31
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'location': location,
<<<<<<< HEAD
      'isWhatsApp': isWhatsApp,
      'isSemesterPaid': isSemesterPaid,
=======
      'picture': picture,
      'userUid': userUid,
>>>>>>> d425cdc95f41d99c525d988e9700634c20036c31
      'interstsModel': interstsModel!.toMap(),
    };
  }
}
