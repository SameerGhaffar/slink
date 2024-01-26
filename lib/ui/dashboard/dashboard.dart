import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slink/ui/widgets/margin_widget.dart';
import 'package:slink/utils/app_string.dart';
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
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: appBar(),
        body: const TabBarView(
          children: [
            Center(
              child: Text("It's cloudy here"),
            ),
            Center(
              child: Text("It's rainy here"),
            ),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
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
      bottom: const TabBar(tabs: [
        Tab(
          icon: Icon(Icons.cloud_outlined),
        ),
        Tab(
          icon: Icon(Icons.beach_access_sharp),
        ),
        Tab(
          icon: Icon(Icons.brightness_5_sharp),
        ),
      ]),
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
