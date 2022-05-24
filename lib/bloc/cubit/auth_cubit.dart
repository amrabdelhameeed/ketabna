import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ketabna/core/models/book_model.dart';
import 'package:ketabna/core/models/intersts_model.dart';
import 'package:ketabna/core/models/request_model.dart';
import 'package:ketabna/core/models/user_model.dart';
import 'package:ketabna/core/utils/random_string.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  bool isTechnical = false;
  late String verificationId;
  var instance = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  File? bookImage;
  Future<String> pickBookImage(String bookId) async {
    String? photoUrl;
    await _picker.pickImage(source: ImageSource.gallery).then((value) {
      bookImage = File(value!.path);
    }).then((value) async {
      emit(PickPhotoLoadingState());
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('books/${Uri.file(bookImage!.path).pathSegments.last}')
          .putFile(bookImage!)
          .then((p0) async {
        await p0.ref.getDownloadURL().then((photoLink) async {
          debugPrint(photoLink);
          photoUrl = photoLink;
          emit(PickPhotoLoadedState());
          return photoUrl;
        });
      });
    });
    emit(PickPhotoLoadedState());
    return photoUrl!;
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required InterstsModel interstsModel,
    required bool isWhatsapp,
    context,
  }) async {
    instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      UserModel userModel = UserModel(
        interstsModel: interstsModel,
        email: email,
        name: name,
        location: "Cairo",
        isWhatsApp: isWhatsapp,
        phone: phone,
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .set(userModel.toJson())
          .then((value) {
        instance.currentUser!.updateDisplayName(name).then((value) {
          debugPrint("name updated");
        });
        instance.currentUser?.updateEmail(email).then((value) {
          debugPrint("email updated");
        });
        submitPhoneNum(phone);
      }).catchError((onError) {
        emit(EmailauthError(onError.toString()));
        debugPrint("eltanya ha eltanya ${onError.toString()}");
      });
    }).then((value) => {
      emit(RegisterSuccessState())
    }).catchError((onError) {
      debugPrint("eltanya ha eltanya ${onError.toString()}");
      final snack = SnackBar(backgroundColor:Colors.red ,content: Text(onError.toString()),duration: Duration(seconds: 2),);

      ScaffoldMessenger.of(context).showSnackBar(snack);
      emit(EmailauthError(onError.toString()));
    });
  }

  Future<void> updateInterstedModel({
    required InterstsModel interstsModel,
  }) async {
    print('updateIntersts');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(getLoggedInUser().uid)
        .update({'interstsModel': interstsModel.toMap()}).then((value) {
      print('Updated Intersts model');
      emit(EmailSubmitted());
    }).catchError((onError) {
      print('error fe update intersts model');
    });
  }

  Future<void> submitPhoneNum(String phoneNum) async {
    emit(PhoneauthLoading());
    await instance.verifyPhoneNumber(
        phoneNumber: '+2$phoneNum',
        timeout: const Duration(seconds: 15),
        verificationCompleted: vervicationCompleted,
        verificationFailed: vervicationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrivalTimeOut);
  }

  void vervicationCompleted(PhoneAuthCredential credential) async {
    debugPrint("vervicationCompleted");
    await signIn(credential);
  }

  void requestAbook() async {}

  void vervicationFailed(FirebaseAuthException error) {
    debugPrint("vervicationFailed : ${error.toString()}");
    emit(PhoneauthError(error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    debugPrint("Code Sent");
    emit(PhoneNumberSubmitted());
  }

  void codeAutoRetrivalTimeOut(String verificationId) {
    debugPrint("codeAutoRetrivalTimeOut");
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> submitOtp(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await instance.currentUser!.updatePhoneNumber(credential);
      emit(OtpVerfied());
    } catch (e) {
      emit(PhoneauthError(e.toString()));
    }
  }

  Future<void> logOut() async {
    await instance.signOut();
  }

  UserModel? userModel;
  Future<List<BookModel>> getSomeBooksByCategory(
      {required String category, int? limit}) async {
    List<BookModel> books = [];
    await FirebaseFirestore.instance
        .collection('books')
        .where('category', isEqualTo: category)
        .where('isValid', isEqualTo: true)
        .limit(limit ?? 10)
        .get()
        .then((value) {
      for (var element in value.docs) {
        books.add(BookModel.fromJson(element.data()));
      }
    });
    debugPrint(books.length.toString());
    return books;
  }

  List<BookModel> reccomendedBooks = [];
  List<BookModel> fantasyInterstBooks = [];
  List<BookModel> fictionInterstBooks = [];
  List<BookModel> horrorInterstBooks = [];
  List<BookModel> novelInterstBooks = [];
  List<BookModel> studingInterstBooks = [];
  List<BookModel> technologyInterstBooks = [];

  void getHorrorBooks() async {
    getSomeBooksByCategory(category: 'horror').then((horrorBooks) {
      horrorInterstBooks = horrorBooks;
      emit(GetHorrorBooksState());
    });
  }

  void getTechnologyBooks() async {
    getSomeBooksByCategory(category: 'technology').then((technologyBooks) {
      technologyInterstBooks = technologyBooks;
      emit(GetTechnologyBooksState());
    });
  }

  void getFantasyBooks() async {
    getSomeBooksByCategory(category: 'fantasy').then((fantasyBooks) {
      fantasyInterstBooks = fantasyBooks;
      emit(GetFantasyBooksState());
    });
  }

  void getnovelBooks() async {
    getSomeBooksByCategory(category: 'novelInterst').then((novelBooks) {
      novelInterstBooks = novelBooks;
      emit(GetnovelBooksState());
    });
  }

  void getfictionBooks() async {
    getSomeBooksByCategory(category: 'scienceFiction').then((fictionBooks) {
      fictionInterstBooks = fictionBooks;
      emit(GetFictionBooksState());
    });
  }

  void getbiographyBooks() async {
    getSomeBooksByCategory(category: 'biography').then((studingBooks) {
      studingInterstBooks = studingBooks;
      emit(GetstudingBooksState());
    });
  }

  void getRecommended() async {
    UserModel? internalUserModel;
    String userUid = getLoggedInUser().uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .get()
        .then((v) {
      internalUserModel = UserModel.fromJson(v.data()!);
    });
    List<MapEntry> map = internalUserModel!.interstsModel!
        .toMap()
        .entries
        .where((element) => element.value == true)
        .toList();
    map.forEach((key) async {
      await getSomeBooksByCategory(category: key.key).then((vv) {
        // reccomendedBooks =
        //     vv.where((element) => !reccomendedBooks.contains(element)).toList();
        vv.forEach((book) {
          if (!reccomendedBooks.contains(book)) {
            reccomendedBooks.add(book);
          }
        });
      });
      emit(GetRecommended());
    });
    debugPrint(reccomendedBooks.length.toString());
  }

  void addBook({
    required String category,
    required String name,
    required String authorName,
  }) async {
    String bookId = RandomString.getRandomString(20);
    await pickBookImage(bookId).then((value) async {
      BookModel bookModel = BookModel(
          ownerUid: instance.currentUser!.uid,
          category: category,
          picture: value,
          name: name,
          bookId: bookId,
          authorName: authorName);
      await FirebaseFirestore.instance
          .collection('books')
          .doc(bookId)
          .set(bookModel.toJson());
    }).then((value) {
      emit(BookAddedSuccessState());
    });
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
    context
  }) async {
    await instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LogedInSuccessState());
    }).catchError((onError) {
      final snack = SnackBar(backgroundColor:Colors.red ,content: Text(onError.toString()),duration: Duration(seconds: 2),);

      ScaffoldMessenger.of(context).showSnackBar(snack);
      debugPrint("5ra error fe login ${onError.toString()}");
    });
  }

  User getLoggedInUser() {
    User firebaseUser = instance.currentUser!;
    return firebaseUser;
  }

  void makeRequest({required RequestModel requestModel}) async {
    FirebaseFirestore.instance
        .collection('requests')
        .doc()
        .set(requestModel.toJson())
        .then((value) {
      debugPrint("requested ya basha");
      emit(BookRequestedState());
    });
  }
}
