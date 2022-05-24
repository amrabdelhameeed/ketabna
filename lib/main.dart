import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/app_router.dart';
import 'package:ketabna/core/constants/observer.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/core/utils/shared_pref_helper.dart';

String initialRoute = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
  bool onBoarding = SharedPrefHelper.getBool(key: 'onBoarding');
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (!onBoarding) {
      initialRoute = splashScreen;
    } else if (user == null) {
      initialRoute = signInUpScreen;
    } else if (user.phoneNumber == null) {
      initialRoute = verificationScreen;
    } else {
      initialRoute = mainScreen;
    }
  });
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        appRouter: AppRouter(),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      onGenerateRoute: appRouter.generateRoutes,
      title: 'Ketabna',
    );
  }
}
