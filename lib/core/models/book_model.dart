import 'package:cloud_firestore/cloud_firestore.dart';

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
      {this.nameAr,
      this.picture,
      this.nameEn,
      this.isValid = true,
      this.authorName,
      this.category,
      this.ownerUid,
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

  List<BookModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;
      return BookModel(
        nameAr: dataMap['nameAr'],
        nameEn: dataMap['nameEn'],
        authorName: dataMap['authorName'],
        picture: dataMap['picture'],
        isValid: dataMap['isValid'],
        category: dataMap['category'],
        ownerUid: dataMap['ownerUid'],
        bookId: dataMap['bookId'],
      );
    }).toList();
  }
}
