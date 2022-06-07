import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ketabna/core/models/book_model.dart';
import 'package:ketabna/core/models/intersts_model.dart';
import 'package:ketabna/core/models/request_model.dart';
import 'package:ketabna/core/models/user_model.dart';
import 'package:ketabna/core/utils/random_string.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ketabna/core/utils/shared_pref_helper.dart';
import 'package:ketabna/features/chat/my_active_chats.dart';
import 'package:ketabna/features/home/home_screen.dart';
import 'package:ketabna/features/home/widgets/add_book.dart';
import 'package:ketabna/features/search/search_screen.dart';
import 'package:ketabna/screens/profile.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  bool isTechnical = false;
  late String verificationId;
  var instance = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  File? bookImage;
  bool isBottomSheetShow = false;
  IconData fabIcon = Icons.add;
  String dropdownValue = 'Biography';
  List<Widget> screenWidget = [
    // write screen widget
    // /* 1 Home Screen */ BlocProvider<AuthCubit>.value(
    //   value: authCubit!
    //     ..getCurrentFirestoreUser()
    //     ..getRecommended()
    //     ..getHorrorBooks()
    //     ..getTechnologyBooks()
    //     ..getFantasyBooks()
    //     ..getnovelBooks()
    //     ..getfictionBooks()
    //     ..getbiographyBooks(),
    //   child:
    HomeScreen(),

    /* 2 Search Screen*/ SearchScreen(
      searchBy: '',
    ),
    /* 3 Add Screen*/ AddBook(),
    /* 4 chat Screen*/
    // BlocProvider<AuthCubit>.value(
    //   value: authCubit!,
    //   child:
    MyActiveChats(),
    // ),
    // /* 5 Profile Screen*/ BlocProvider<AuthCubit>.value(
    //   value: authCubit!..getUserBooks(),
    //   child:
    ProfileScreen(),
    // ),
  ];

  Future<UserModel> getUserModelByOwnerUid(String uId) async {
    UserModel? internalUserModel;
    String userUid = uId;
    final futureData =
        await FirebaseFirestore.instance.collection('users').doc(userUid).get();
    return UserModel.fromJson(futureData.data()!);
  }

  int curIndex = 0;
  void changeIndex(int index) {
    curIndex = index;
    if (index == 4) {
      getCurrentFirestoreUser();
    }
    emit(ChangeIndexState());
  }

  Future<File> pickBookImage(bool isCam) async {
    String? photoUrl;
    await _picker
        .pickImage(source: !isCam ? ImageSource.gallery : ImageSource.camera)
        .then((value) {
      bookImage = File(value!.path);
      emit(PickPhotoLoadedState());
    });
    // .then((value) async {
    //   emit(PickPhotoLoadingState());
    //   await firebase_storage.FirebaseStorage.instance
    //       .ref()
    //       .child('books/${Uri.file(bookImage!.path).pathSegments.last}')
    //       .putFile(bookImage!)
    //       .then((p0) async {
    //     await p0.ref.getDownloadURL().then((photoLink) async {
    //       debugPrint(photoLink);
    //       photoUrl = photoLink;
    //       emit(PickPhotoLoadedState());
    //       return photoUrl;
    //     });
    //   });
    // });
    return bookImage!;
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required InterstsModel interstsModel,
    required String location,
    context,
  }) async {
    instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          UserModel userModel = UserModel(
              interstsModel: interstsModel,
              userUid: value.user!.uid,
              email: email,
              name: name,
              location: location,
              phone: phone,
              picture: '');
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
        })
        .then(
          (value) async => {
            await SharedPrefHelper.putStr(key: 'userName', value: name),
            emit(
              RegisterSuccessState(),
            ),
          },
        )
        .catchError((onError) {
          debugPrint("eltanya ha eltanya ${onError.toString()}");
          final snack = SnackBar(
            backgroundColor: Colors.red,
            content: Text(onError.toString()),
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          emit(EmailauthError(onError.toString()));
        });
  }

  Future<void> updateName({
    required String name,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(getLoggedInUser().uid)
        .update({'name': name}).then((value) {
      print('updateName success');
      emit(EmailSubmitted());
      getCurrentFirestoreUser();
    }).catchError((onError) {
      print('error fe updateName');
    });
  }

  Future<void> toggleSwitchOfBooks(
      {required BookModel book, required bool val}) async {
    bool localIsValid = val;
    print(localIsValid);
    await FirebaseFirestore.instance
        .collection('books')
        .doc(book.bookId)
        .update({'isValid': localIsValid}).then((value) {
      print('toggleSwitchOfBooks success');
      emit(EmailSubmitted());
    }).catchError((onError) {
      print('error fe toggleSwitchOfBooks');
    });
  }

  Future<void> deleteBook({required BookModel book}) async {
    await FirebaseFirestore.instance
        .collection('books')
        .doc(book.bookId)
        .delete()
        .then((value) {
      print('delete book state');
      emit(EmailSubmitted());
    }).catchError((onError) {
      print('error fe delete book');
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

  UserModel getCurrentFirestoreUser() {
    String userUid = getLoggedInUser().uid;
    FirebaseFirestore.instance.collection('users').doc(userUid).get().then((v) {
      userModel = UserModel.fromJson(v.data()!);
      emit(GetBooksSuccessState());
    });
    return userModel!;
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

  List<BookModel> userBooks = [];
  Future<List<BookModel>> getUserBook(
      {required String userUid, bool? isMyBooks}) async {
    List<BookModel> books = [];
    isMyBooks!
        ? await FirebaseFirestore.instance
            .collection('books')
            .where('ownerUid', isEqualTo: userUid)
            .get()
            .then((value) {
            for (var element in value.docs) {
              books.add(BookModel.fromJson(element.data()));
            }
          })
        : await FirebaseFirestore.instance
            .collection('books')
            .where('ownerUid', isEqualTo: userUid)
            .where('isValid', isEqualTo: true)
            .get()
            .then((value) {
            for (var element in value.docs) {
              books.add(BookModel.fromJson(element.data()));
            }
          });
    debugPrint(books.length.toString());
    return books;
  }

  void getUserBooks({String? uId}) async {
    print(instance.currentUser!.uid);
    getUserBook(
            userUid: uId ?? instance.currentUser!.uid, isMyBooks: uId == null)
        .then((x) {
      userBooks = [];
      userBooks = x;
      print('books : ${userBooks.length}');
      emit(GetnovelBooksState());
    });
  }

  Future editProfilePicture() async {
    String? photoUrl;
    // emit(PickPhotoLoadingState());
    await pickBookImage(false).then((value) {
      String userUid = instance.currentUser!.uid;
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('books/${Uri.file(bookImage!.path).pathSegments.last}')
          .putFile(value)
          .then((p0) async {
        await p0.ref.getDownloadURL().then((photoLink) async {
          debugPrint(photoLink);
          photoUrl = photoLink;
          emit(PickPhotoLoadedState());
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userUid)
              .update({'picture': photoLink});
        }).then((value) {
          userModel = getCurrentFirestoreUser();
          emit(BookAddedSuccessState());
          bookImage = null;
        });
      });
    });
  }

  void addBook({
    required String category,
    required String name,
    required String authorName,
    required String describtion,
  }) async {
    String? photoUrl;
    String bookId = RandomString.getRandomString(20);
    // emit(PickPhotoLoadingState());
    if (bookImage != null) {
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('books/${Uri.file(bookImage!.path).pathSegments.last}')
          .putFile(bookImage!)
          .then((p0) async {
        await p0.ref.getDownloadURL().then((photoLink) async {
          debugPrint(photoLink);
          photoUrl = photoLink;
          emit(PickPhotoLoadedState());
          BookModel bookModel = BookModel(
              ownerUid: instance.currentUser!.uid,
              category: category,
              picture: photoUrl,
              name: name,
              describtion: describtion,
              bookId: bookId,
              authorName: authorName);
          await FirebaseFirestore.instance
              .collection('books')
              .doc(bookId)
              .set(bookModel.toJson());
        }).then((value) {
          emit(BookAddedSuccessState());
          bookImage = null;
        });
      });
    }
  }

  Future<void> loginWithEmailAndPassword(
      {required String email, required String password, context}) async {
    await instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((value) async => {
                print('name : ' + value['name']),
                await SharedPrefHelper.putStr(
                    key: 'userName', value: value['name'])
              });
      emit(LogedInSuccessState());
    }).catchError((onError) {
      final snack = SnackBar(
        backgroundColor: Colors.red,
        content: Text(onError.toString()),
        duration: Duration(seconds: 2),
      );

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

  void bottomSheetShowState({required bool isShow, required IconData icon}) {
    isBottomSheetShow = isShow;
    fabIcon = icon;
    emit(AppChangeSheetShowState());
  }

  void dropdownValueState({required String value}) {
    dropdownValue = value;
    emit(dropdownValueSheetShowState());
  }
}
