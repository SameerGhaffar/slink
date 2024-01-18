import 'package:flutter/material.dart';
import 'package:slink/ui/widgets/app_bar.dart';
import 'package:slink/ui/widgets/margin_widget.dart';
import 'package:slink/ui/widgets/text_field.dart';
import 'package:slink/ui/widgets/text_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController email;

  late TextEditingController password;
  late TextEditingController confirmPassword;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "SignUp"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFieldWidget(controller: email, hint: 'Email'),
                const MarginWidget(factor: 0.5),
                TextFieldWidget(controller: password, hint: "Password"),
                const MarginWidget(factor: 0.5),
                TextFieldWidget(
                    controller: confirmPassword, hint: "Confirm Password"),
                const MarginWidget(),
                const TextButtonWidget(text: "SignUp"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
