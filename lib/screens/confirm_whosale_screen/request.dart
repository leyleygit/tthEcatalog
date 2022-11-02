import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecatalog/components/custom_gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CustomGradientElevatedButton(
            height: 50.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Confirm order now',
                    style: TextStyle(color: Colors.white),
                  )
                ]),
            onPressed: () {
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  width: 400,
                  buttonsBorderRadius: const BorderRadius.all(
                    Radius.circular(14.0),
                  ),
                  dismissOnTouchOutside: true,
                  dismissOnBackKeyPress: false,
                  headerAnimationLoop: false,
                  animType: AnimType.bottomSlide,
                  title: 'Are you sure to Confirm order now?',
                  titleTextStyle: TextStyle(color: Color(0xFF235225)),
                  //desc: 'This Dialog can be dismissed touching outside',
                  showCloseIcon: true,
                  btnCancel: CustomGradientElevatedButton(
                    height: 40.0,
                    listColor: [
                      Colors.red,
                      Color.fromARGB(255, 150, 42, 34),
                      Color.fromARGB(255, 106, 28, 22)
                    ],
                    child: Text(
                      'no',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  btnOk: CustomGradientElevatedButton(
                    height: 40,
                    child: Text(
                      'yes',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context, 'yes');
                    },
                  )).show().then((value) {
                if (value == null) {
                } else {
                  Navigator.pop(context, value);
                }
              });
            }),
      ),
    );
  }
}
