import 'dart:convert';

class InterstsModel {
  bool? fantasyInterst;
  bool? fictionInterst;
  bool? horrorInterst;
  bool? novelInterst;
  bool? studingInterst;
  bool? technologyInterst;
  InterstsModel(
      {required this.fantasyInterst,
      required this.fictionInterst,
      required this.horrorInterst,
      required this.novelInterst,
      required this.studingInterst,
      required this.technologyInterst});
  InterstsModel.fromMap(Map<String, dynamic> map) {
    fantasyInterst = map['fantasyInterst'];
    fictionInterst = map['fictionInterst'];
    horrorInterst = map['horrorInterst'];
    novelInterst = map['novelInterst'];
    studingInterst = map['studingInterst'];
    technologyInterst = map['technologyInterst'];
  }
  Map<String, dynamic> toMap() {
    return {
      'fantasyInterst': fantasyInterst ?? false,
      'fictionInterst': fictionInterst ?? false,
      'horrorInterst': horrorInterst ?? false,
      'novelInterst': novelInterst ?? false,
      'studingInterst': studingInterst ?? false,
      'technologyInterst': technologyInterst ?? false,
    };
  }

  factory InterstsModel.fromJson(String str) =>
      InterstsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
}
