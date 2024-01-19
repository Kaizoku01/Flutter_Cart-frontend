import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/logic/cubits/user_cubit/user_cubit.dart';
import 'package:flutter_cart/logic/cubits/user_cubit/user_state.dart';

import '../screens/auth/login_screen.dart';
import '../screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "splash";
  @override
  State<SplashScreen> createState() => _SplashScreeState();
}

class _SplashScreeState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(milliseconds: 100), () {
      goToNextScreen();
    });
    super.initState();
  }


  void goToNextScreen(){
    UserState userState = BlocProvider.of<UserCubit>(context).state;

    if(userState is UserLoggedInState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
    else if(userState is UserLoggedOutState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
    else if(userState is UserErrorState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }



  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (BuildContext context, state) {
        goToNextScreen();
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
