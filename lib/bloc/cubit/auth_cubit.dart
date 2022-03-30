import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/core/models/book_model.dart';
import 'package:ketabna/core/models/user_model.dart';
import 'package:ketabna/core/utils/random_string.dart';
import 'package:meta/meta.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  bool isTechnical = false;
  late String verificationId;
  var instance = FirebaseAuth.instance;
  Future<void> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String name,
      required String intersts,
      required String phone,
      required bool fantasyInterst,
      required bool fictionInterst,
      required bool horrorInterst,
      required bool novelInterst,
      required bool studingInterst,
      required bool technologyInterst}) async {
    instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      UserModel userModel = UserModel(
        fantasyInterst: fantasyInterst,
        fictionInterst: fictionInterst,
        horrorInterst: horrorInterst,
        novelInterst: novelInterst,
        studingInterst: studingInterst,
        technologyInterst: technologyInterst,
        email: email,
        name: name,
        location: "Cairo",
        isWhatsApp: true,
        phone: instance.currentUser!.phoneNumber ?? "no phone",
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .set(userModel.toJson())
          .then((value) {
        // emit(EmailSubmitted());\
        instance.currentUser!.updateDisplayName(name).then((value) {
          print("name updated");
        });
        instance.currentUser?.updateEmail(email).then((value) {
          print("email updated");
        });
        submitPhoneNum(phone);
      }).catchError((onError) {
        emit(EmailauthError(onError.toString()));
        print("eltanya ha eltanya ${onError.toString()}");
      });
    }).catchError((onError) {
      print("eltanya ha eltanya ${onError.toString()}");
      emit(EmailauthError(onError.toString()));
    });
  }
  // Future<Void> firestoreCreateUser(
  //     {required String email, required String password}) {
  // }

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
    print("vervicationCompleted");
    await signIn(credential);
  }

  void requestAbook() async {}

  void vervicationFailed(FirebaseAuthException error) {
    print("vervicationFailed : ${error.toString()}");
    emit(PhoneauthError(error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    print("Code Sent");
    emit(PhoneNumberSubmitted());
  }

  void codeAutoRetrivalTimeOut(String verificationId) {
    print("codeAutoRetrivalTimeOut");
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

  List<BookModel> books = [];

  UserModel? userModel;
  void getAllBooksByCategory({required String category}) async {
    print(instance.currentUser!.uid);
    await FirebaseFirestore.instance
        .collection('books')
        .where('ownerUid', isEqualTo: instance.currentUser!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        books.add(BookModel.fromJson(element.data()));
      });
    });
    // await FirebaseFirestore.instance
    //     .collection('books')
    //     .where('ownerUid', isEqualTo: instance.currentUser!.uid)
    //     .get()
    //     .then((value) {
    //   value.docs.asMap().forEach((key, value) {
    //     books[key].bookId = value.id;
    //   });
    //   emit(GetBooksSuccessState());
    // });
    // print(books.first.bookId);
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(books[0].ownerUid)
    //     .get()
    //     .then((value) {
    //   userModel = UserModel.fromJson(value.data()!);
    // });
    // print(userModel!.email);
    // emit(GetUserByUidState(userModel!));
  }

  void addBook({
    required String category,
    required String nameAr,
    required String nameEn,
    required String picture,
    required String authorName,
  }) async {
    String bookId = RandomString.getRandomString(20);
    BookModel bookModel = BookModel(
        ownerUid: instance.currentUser!.uid,
        category: category,
        nameAr: nameAr,
        picture: picture,
        nameEn: nameEn,
        isValid: true,
        bookId: bookId,
        authorName: authorName);
    FirebaseFirestore.instance
        .collection('books')
        .doc(bookId)
        .set(bookModel.toJson())
        .then((value) {
      print("tamam ya basha");
    });
  }

  void loginWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LogedInSuccessState());
    }).catchError((onError) {
      print("5ra error fe login ${onError.toString()}");
    });
  }

  User getLoggedInUser() {
    User firebaseUser = instance.currentUser!;
    return firebaseUser;
  }
}
