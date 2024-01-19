import 'package:flutter/material.dart';
import 'package:flutter_cart/presentation/screens/auth/providers/signup_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/ui.dart';
import '../../widgets/gap_widget.dart';
import '../../widgets/link_button.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_text_field.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String routeName = "signup";
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);
    return Scaffold(
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
              "Create Account",
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
            const GapWidget(),
            PrimaryTextField(
                labelText: "Confirm Password",
                controller: provider.cPasswordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Password is required!";
                  }

                  if(value.trim() != provider.passwordController.text){
                    return "Password do not match";
                  }

                  return null;
                }),
            const GapWidget(),
            PrimaryButton(
              text: (provider.isLoading) ? "..." : "Create Account",
              onPressed: provider.createAccount,
            ),
            const GapWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 16),
                LinkButton(
                  text: "Log In",
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
