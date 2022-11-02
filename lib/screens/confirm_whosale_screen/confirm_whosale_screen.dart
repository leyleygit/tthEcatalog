import 'package:ecatalog/screens/confirm_whosale_screen/approved.dart';
import 'package:ecatalog/screens/confirm_whosale_screen/decline.dart';
import 'package:ecatalog/screens/confirm_whosale_screen/request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ConfirmWhosaleScreen extends StatefulWidget {
  const ConfirmWhosaleScreen({super.key});

  @override
  State<ConfirmWhosaleScreen> createState() => _ConfirmWhosaleScreenState();
}

class _ConfirmWhosaleScreenState extends State<ConfirmWhosaleScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      animationDuration: const Duration(milliseconds: 500),
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  Text(
                    'Whosale request',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ],
              ),
              leading: IconButton(
                splashRadius: 25,
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.back,
                  color: Colors.black,
                ),
              ),
              elevation: 0,
              toolbarHeight: 90,
              bottom: TabBar(
                  overlayColor: MaterialStateProperty.resolveWith(
                      (states) => Color.fromARGB(255, 236, 255, 237)),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: TextStyle(color: Colors.green),
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Color.fromARGB(255, 35, 82, 37),
                  tabs: [
                    Tab(
                      child: Text("Requesting"),
                    ),
                    Tab(
                      child: Text("Approved"),
                    ),
                    Tab(
                      child: Text("Decline"),
                    )
                  ])),
          backgroundColor: const Color(0xffFBFDF7),
          body: TabBarView(
            children: [RequestScreen(), ApprovedScreen(), DeclineScreen()],
          )),
    );
  }
}
