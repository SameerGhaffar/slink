import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slink/ui/auth/signup.dart';
import 'package:slink/ui/widgets/app_bar.dart';
import 'package:slink/ui/widgets/margin_widget.dart';
import 'package:slink/ui/widgets/text_field.dart';
import 'package:slink/ui/widgets/text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController email;

  late TextEditingController password;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBarWidget(title: "Login"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFieldWidget(controller: email, hint: 'Email'),
                const MarginWidget(factor: 0.5,),
                TextFieldWidget(controller: password, hint: "Password"),
                const MarginWidget(),
                TextButtonWidget(
                  text: "Login",
                  onPressed: () {},
                ),
                const MarginWidget(
                  factor: 0.5,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Don't have a Account? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(() => const SignUpScreen()),
                        text: "Signup Now",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
