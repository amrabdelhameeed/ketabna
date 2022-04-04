import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/features/authentication/otp/varification_screen.dart';
import 'package:ketabna/features/home/home.dart';
import 'package:ketabna/features/authentication/sign_up/signup_screen.dart';
import 'package:ketabna/features/on_boarding/Splash_view.dart';
import 'package:ketabna/features/on_boarding/on_boarding_screen.dart';

class AppRouter {
  AuthCubit? authCubit;

  AppRouter() {
    authCubit = AuthCubit();
  }

  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case onBoardingScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: OnBoardingScreen(),
          );
        });
      case splashScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: SplashView(),
          );
        });
      case mainScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: Home(),
          );
        });
      // case loginScreen:
      //   return MaterialPageRoute(builder: (_) {
      //     return BlocProvider<AuthCubit>.value(
      //       value: authCubit!,
      //       child: LoginScreen(),
      //     );
      //   });
      case otpscreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: VerificationScreen(),
          );
        });
      case registerScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: SignupPage(),
          );
        });
    }
    return null;
  }
}
