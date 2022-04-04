import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/features/authentication/login/login_screen.dart';
import 'package:ketabna/features/authentication/on_boarding/sgin_in_up_screen.dart';
import 'package:ketabna/features/authentication/otp/varification_screen.dart';
import 'package:ketabna/features/home/home.dart';
import 'package:ketabna/features/authentication/sign_up/signup_screen.dart';

class AppRouter {
  AuthCubit? authCubit;

  AppRouter() {
    authCubit = AuthCubit();
  }

  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case mainScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: Home(),
          );
        });
      case loginScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<AuthCubit>.value(
            value: authCubit!,
            child: LoginScreen(),
          );
        });
      case otpscreen:
        // final phonenum = settings.arguments;
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
