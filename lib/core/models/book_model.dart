import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  String? name;
  String? authorName;
  String? picture;
  bool? isValid;
  String? category;
  String? ownerUid;
  String? ownerName;
  String? bookId;
  BookModel(
      {this.name,
      this.picture,
      this.isValid = true,
      this.authorName,
      this.category,
      this.ownerUid,
      this.ownerName,
      this.bookId});
  BookModel.fromJson(Map<String, dynamic> map) {
    name = map['name'];
    authorName = map['authorName'];
    picture = map['picture'];
    isValid = map['isValid'];
    category = map['category'];
    ownerUid = map['ownerUid'];
    ownerName = map['ownerName'];
    bookId = map['bookId'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'authorName': authorName,
      'picture': picture,
      'isValid': isValid,
      'category': category,
      'ownerUid': ownerUid,
      'ownerName': ownerName,
      'bookId': bookId,
    };
  }

  List<BookModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;
      return BookModel(
        name: dataMap['name'],
        authorName: dataMap['authorName'],
        picture: dataMap['picture'],
        isValid: dataMap['isValid'],
        category: dataMap['category'],
        ownerUid: dataMap['ownerUid'],
        ownerName: dataMap['ownerName'],
        bookId: dataMap['bookId'],
      );
    }).toList();
  }
}
