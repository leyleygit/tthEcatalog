import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecatalog/components/custom_gradient_elevated_button.dart';
import 'package:flutter/material.dart';

class DeclineButton extends StatefulWidget {
  const DeclineButton({
    Key? key,
  }) : super(key: key);

  @override
  State<DeclineButton> createState() => _DeclineButtonState();
}

class _DeclineButtonState extends State<DeclineButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(),
        onPressed: () {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.warning,
              width: 400,
              buttonsBorderRadius: const BorderRadius.all(
                Radius.circular(14.0),
              ),
              dismissOnTouchOutside: true,
              dismissOnBackKeyPress: false,
              headerAnimationLoop: false,
              animType: AnimType.bottomSlide,
              title: 'Are you sure to Decline?',
              titleTextStyle: TextStyle(color: Color(0xFF235225)),
              //desc: 'This Dialog can be dismissed touching outside',
              showCloseIcon: true,
              btnCancel: CustomGradientElevatedButton(
                height: 40,
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
                onPressed: () {},
              )).show();
        },
        child: Text(
          'Decline',
          style: TextStyle(color: Colors.green),
        ));
  }
}
