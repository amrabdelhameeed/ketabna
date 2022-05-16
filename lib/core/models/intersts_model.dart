import 'dart:convert';

class InterstsModel {
  bool? biography;
  bool? children;
  bool? fantasy;
  bool? graphicNovels;
  bool? history;
  bool? horror;
  bool? romance;
  bool? scienceFiction;
  InterstsModel(
      {required this.biography,
      required this.children,
      required this.fantasy,
      required this.graphicNovels,
      required this.history,
      required this.horror,
      required this.romance,
      required this.scienceFiction});
  InterstsModel.fromMap(Map<String, dynamic> map) {
    biography = map['biography'];
    children = map['children'];
    fantasy = map['fantasy'];
    graphicNovels = map['graphicNovels'];
    history = map['history'];
    horror = map['horror'];
    romance = map['romance'];
    scienceFiction = map['scienceFiction'];
  }
  Map<String, dynamic> toMap() {
    return {
      'biography': biography ?? false,
      'children': children ?? false,
      'fantasy': fantasy ?? false,
      'graphicNovels': graphicNovels ?? false,
      'history': history ?? false,
      'horror': horror ?? false,
      'romance': romance ?? false,
      'scienceFiction': scienceFiction ?? false
    };
  }

  factory InterstsModel.fromJson(String str) =>
      InterstsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
  static const List<String> categorys = [
    'biography',
    'children',
    'fantasy',
    'graphicNovels',
    'history',
    'horror',
    'romance',
    'scienceFiction'
  ];
}
