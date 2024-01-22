import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slink/cubit/auth_cubit/auth_cubit.dart';
import 'package:slink/ui/widgets/app_bar.dart';
import 'package:slink/ui/widgets/margin_widget.dart';
import 'package:slink/ui/widgets/text_field.dart';
import 'package:slink/ui/widgets/primary_button.dart';
import 'package:email_validator/email_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController email;

  late TextEditingController password;
  late TextEditingController confirmPassword;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    formKey = GlobalKey<FormState>();
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
                  const MarginWidget(factor: 0.5),
                  TextFieldWidget(
                    controller: password,
                    hint: "Password",
                    validator: (value) {
                      if (value == null) {
                        return "Password is required";
                      } else {
                        if (value.length < 7) {
                          return "Password must be of 8 Characters";
                        }
                        return null;
                      }
                    },
                  ),
                  const MarginWidget(factor: 0.5),
                  TextFieldWidget(
                    controller: confirmPassword,
                    hint: "Confirm Password",
                    validator: (value) {
                      if (value == null) {
                        return "Please Enter same Password";
                      } else {
                        if (value != password.text) {
                          return "Password is not Same";
                        }
                        return null;
                      }
                    },
                  ),
                  const MarginWidget(),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return PrimaryButton(
                        text: "SignUp",
                        isLoading: state.userState,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await context.read<AuthCubit>().signUp(
                                email: email.text.trim(),
                                password: password.text.trim());
                          }
                        },
                      );
                    },
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
