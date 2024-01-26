import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slink/bloc/auth_bloc/auth_cubit.dart';
import 'package:slink/ui/auth/signup.dart';
import 'package:slink/ui/dashboard/dashboard.dart';
import 'package:slink/ui/widgets/app_bar.dart';
import 'package:slink/ui/widgets/margin_widget.dart';
import 'package:slink/ui/widgets/text_field.dart';
import 'package:slink/ui/widgets/primary_button.dart';
import 'package:slink/utils/extensions.dart';
import 'package:slink/utils/state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController email;
  late TextEditingController password;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    formKey = GlobalKey<FormState>();
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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFieldWidget(
                    controller: email,
                    hint: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Email";
                      } else {
                        final bool isValid = EmailValidator.validate(value);
                        if (!isValid) {
                          return "Please Enter Valid Email";
                        }
                        return null;
                      }
                    },
                  ),
                  const MarginWidget(
                    factor: 0.5,
                  ),
                  TextFieldWidget(
                    controller: password,
                    hint: "Password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Password";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const MarginWidget(),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {

                    },
                    builder: (context, state) {
                      return PrimaryButton(
                        text: "Login",
                        isLoading: state.userState,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await context.read<AuthCubit>().logIn(
                                context: context,
                                email: email.text.trim(),
                                password: password.text.trim());
                            print(state.userState);
                            if (state.userState == DataState.success) {
                              context.pushAndRemoveUntil(
                                  child: const DashBoardScreen());
                            }
                          }
                        },
                      );
                    },
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
                            ..onTap = () {
                              context.push(child: const SignUpScreen());
                            },
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
      ),
    );
  }
}
