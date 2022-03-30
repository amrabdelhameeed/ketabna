class RequestModel {
  String? senderUid;
  String? reciverUid;
  String? bookId;
  bool? isAccepted;
  RequestModel({
    required this.senderUid,
    required this.reciverUid,
    required this.isAccepted,
    required this.bookId,
  });
  RequestModel.fromJson(Map<String, dynamic> map) {
    senderUid = map['senderUid'];
    reciverUid = map['reciverUid'];
    bookId = map['bookId'];
    isAccepted = map['isAccepted'];
  }
  Map<String, dynamic> toJson() {
    return {
      'senderUid': senderUid,
      'bookId': bookId,
      'reciverUid': reciverUid,
      'isAccepted': isAccepted,
    };
  }
}
