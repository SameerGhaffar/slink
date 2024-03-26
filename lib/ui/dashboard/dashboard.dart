import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slink/bloc/auth_bloc/auth_cubit.dart';
import 'package:slink/ui/widgets/margin_widget.dart';
import 'package:slink/ui/widgets/test_button.dart';
import 'package:slink/utils/app_string.dart';
import 'package:slink/utils/colors.dart';
import 'package:slink/utils/extensions.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    double height = context.height;
    double width = context.width;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          initialIndex: state.tabIndex,
          child: Scaffold(
            appBar: appBar(),
            body: TabBarView(
              children: [
                body1(context, state),
                const Center(
                  child: Text("It's rainy here"),
                ),
                const Center(
                  child: Text("It's sunny here"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Center body1(BuildContext context, AuthState state) {
    print(state.tabIndex);
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              context.read<AuthCubit>().addIndex(1);
            },
            child: SizedBox(
              height: 52,
              width: 200,
              child: Frame(
                bgGradient: CColors.innerBodyLinearGradient(),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.blue.withOpacity(0.1),
      centerTitle: true,
      title: const Text(
        Constants.appName,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
        ),
      ],
      leadingWidth: context.width * 0.2,
      leading: profileImage(),
      bottom: TabBar(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        dividerHeight: 0.0,
        overlayColor: Colors.transparent.toMaterialStateProperty(),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.blue,
        indicatorSize: TabBarIndicatorSize.tab,
        physics: const NeverScrollableScrollPhysics(),
        tabs: [
          const Tab(
            child: Text("Chat"),
          ),
          const Tab(
            child: Text("Status"),
          ),
          const Tab(
            child: Text("Groups"),
          ),
        ],
      ),
    );
  }

  Widget profileImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const MarginWidget(
            factor: 0.5,
            isHorizontal: true,
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.7),
                // Change this to your desired color
                width: 2, // Change this to your desired width
              ),
            ),
            child: CircleAvatar(
              backgroundImage: const NetworkImage(
                "https://ca.slack-edge.com/T02JFTK6RPW-U0600FR083T-917f7b939c19-512",
              ),
              radius: context.width * 0.075, // Half of the image size
            ),
          )
        ],
      ),
    );
  }
}
