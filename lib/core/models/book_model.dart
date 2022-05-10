class BookModel {
  String? nameAr;
  String? nameEn;
  String? authorName;
  String? picture;
  bool? isValid;
  String? category;
  String? ownerUid;
  String? bookId;
  BookModel(
      {required this.nameAr,
      required this.picture,
      required this.nameEn,
      this.isValid=true,
      required this.authorName,
      required this.category,
      required this.ownerUid,
      this.bookId});
  BookModel.fromJson(Map<String, dynamic> map) {
    nameAr = map['nameAr'];
    nameEn = map['nameEn'];
    authorName = map['authorName'];
    picture = map['picture'];
    isValid = map['isValid'];
    category = map['category'];
    ownerUid = map['ownerUid'];
    bookId = map['bookId'];
  }
  Map<String, dynamic> toJson() {
    return {
      'nameAr': nameAr,
      'authorName': authorName,
      'nameEn': nameEn,
      'picture': picture,
      'isValid': isValid,
      'category': category,
      'ownerUid': ownerUid,
      'bookId': bookId,
    };
  }
}
