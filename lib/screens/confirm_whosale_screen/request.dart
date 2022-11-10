import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecatalog/components/custom_confirm_wholesale_card.dart';
import 'package:ecatalog/components/custom_gradient_elevated_button.dart';
import 'package:ecatalog/data/status_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rxdart/subjects.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({
    super.key,
  });

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  String status = 'request';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(height: 20),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 0,
                  childAspectRatio: 1.0,
                  mainAxisExtent: 180),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomConfrimWholesaleCard(
                      status: status,
                      index: index,
                      onPressed: () {},
                    ),
                  );
                },
                childCount: status.length,
              ),
            )
          ],
        ));
  }
}
