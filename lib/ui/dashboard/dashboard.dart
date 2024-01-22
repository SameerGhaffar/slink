import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slink/cubit/auth_cubit/auth_cubit.dart';
import 'package:slink/ui/dashboard/auth/login.dart';
import 'package:slink/ui/widgets/app_bar.dart';
import 'package:slink/ui/widgets/primary_button.dart';
import 'package:slink/utils/extensions.dart';
import 'package:slink/utils/state.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "SLINK",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text("Dashboard Screen"),
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              return PrimaryButton(
                isLoading: state.userState,
                text: "Logout",
                onPressed: () async {
                  await context.read<AuthCubit>().logOut();
                  if (state.userState == DataState.success) {
                    context.pushAndRemoveUntil(child: const LoginScreen());
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
