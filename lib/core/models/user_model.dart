class UserModel {
  String? phone;
  String? name;
  String? email;
  String? location;
  // String? intersts;
  bool? isWhatsApp;
  bool? novelInterst;
  bool? technologyInterst;
  bool? studingInterst;
  bool? fantasyInterst;
  bool? horrorInterst;
  bool? fictionInterst;

  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.location,
    // required this.intersts,
    required this.isWhatsApp,
    required this.novelInterst,
    required this.technologyInterst,
    required this.studingInterst,
    required this.fantasyInterst,
    required this.horrorInterst,
    required this.fictionInterst,
  });
  UserModel.fromJson(Map<String, dynamic> map) {
    email = map['email'];
    phone = map['phone'];
    name = map['name'];
    location = map['location'];
    // intersts = map['intersts'];
    isWhatsApp = map['isWhatsApp'];
    novelInterst = map['novelInterst'];
    studingInterst = map['studingInterst'];
    technologyInterst = map['technologyInterst'];
    fantasyInterst = map['fantasyInterst'];
    horrorInterst = map['horrorInterst'];
    fictionInterst = map['fictionInterst'];
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'location': location,
      // 'intersts': intersts,
      'isWhatsApp': isWhatsApp,
      'novelInterst': novelInterst,
      'technologyInterst': technologyInterst,
      'studingInterst': studingInterst,
      'fantasyInterst': fantasyInterst,
      'horrorInterst': horrorInterst,
      'fictionInterst': fictionInterst,
    };
  }
}
