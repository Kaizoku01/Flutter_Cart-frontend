import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/core/ui.dart';
import 'package:flutter_cart/logic/cubits/user_cubit/user_cubit.dart';
import 'package:flutter_cart/presentation/screens/auth/providers/login_provider.dart';
import 'package:flutter_cart/presentation/screens/auth/signup_screen.dart';
import 'package:flutter_cart/presentation/splash/splash_screen.dart';
import 'package:flutter_cart/presentation/widgets/gap_widget.dart';
import 'package:flutter_cart/presentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';

import '../../../logic/cubits/user_cubit/user_state.dart';
import '../../widgets/link_button.dart';
import '../../widgets/primary_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "login";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text("Flutter-Cart"),
        ),
        body: Form(
          key: provider.formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                "Log In",
                style: TextStyles.heading2,
              ),
              const GapWidget(size: -10),
              (provider.error != "")
                  ? Text(
                      provider.error,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const SizedBox(),
              const GapWidget(size: 5),
              PrimaryTextField(
                  labelText: "Email Address",
                  controller: provider.emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email address is required!";
                    }
                    final RegExp emailRegExp = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      caseSensitive: false,
                      unicode: false,
                    );
                    if (!emailRegExp.hasMatch(value)) {
                      return "Email Format is wrong!";
                    }
                    return null;
                  }),
              const GapWidget(),
              PrimaryTextField(
                  labelText: "Password",
                  controller: provider.passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password is required!";
                    }
                    return null;
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LinkButton(
                    text: "Forgot Password?",
                    onPressed: () {},
                  ),
                ],
              ),
              const GapWidget(),
              PrimaryButton(
                text: (provider.isLoading) ? "..." : "Log In",
                onPressed: provider.logIn,
              ),
              const GapWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 16),
                  LinkButton(
                    text: "Sign Up",
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
