import 'package:ecatalog/data/status_data.dart';
import 'package:ecatalog/screens/confirm_whosale_screen/approved.dart';
import 'package:ecatalog/screens/confirm_whosale_screen/decline.dart';
import 'package:ecatalog/screens/confirm_whosale_screen/request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rxdart/subjects.dart';

class WholesaleRequestScreen extends StatefulWidget {
  const WholesaleRequestScreen({super.key});

  @override
  State<WholesaleRequestScreen> createState() => _WholesaleRequestScreenState();
}

class _WholesaleRequestScreenState extends State<WholesaleRequestScreen> {
  BehaviorSubject<List<String>> subjectListStatus =
      BehaviorSubject<List<String>>();
  @override
  void initState() {
    super.initState();
    subjectListStatus.add(status);
  }

  @override
  void dispose() {
    super.dispose();
    subjectListStatus.close();
  }

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
                    'Wholesale request',
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
