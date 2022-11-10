import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecatalog/components/custom_gradient_elevated_button.dart';
import 'package:ecatalog/components/decline_button.dart';
import 'package:ecatalog/screens/confirm_whosale_screen/wholesale_request_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomConfrimWholesaleCard extends StatefulWidget {
  final String status;
  final VoidCallback onPressed;
  final int index;
  const CustomConfrimWholesaleCard({
    Key? key,
    required this.index,
    required this.onPressed,
    required this.status,
  }) : super(key: key);

  @override
  State<CustomConfrimWholesaleCard> createState() =>
      _CustomConfrimWholesaleCardState();
}

class _CustomConfrimWholesaleCardState
    extends State<CustomConfrimWholesaleCard> {
  getStatusIcon(String status) {
    switch (status) {
      case 'request':
        return const SizedBox();

      case 'approved':
        return const Icon(
          CupertinoIcons.check_mark_circled_solid,
          color: Colors.green,
        );
      case 'declined':
        return const Icon(
          CupertinoIcons.clear_circled_solid,
          color: Colors.red,
        );
      default:
    }
  }

  getStatusButton(String status) {
    switch (status) {
      case 'request':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DeclineButton(),
            SizedBox(
              width: 50,
            ),
            CustomGradientElevatedButton(
                height: 40,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Confirm',
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
                      title: 'តើអ្នកយល់ព្រមទទួលដែរ ឬទេ ?',
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
                          'ទេ',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          // Navigator.pop(context);
                        },
                      ),
                      btnOk: CustomGradientElevatedButton(
                        height: 40,
                        child: Text(
                          'បាទ / ចាស់',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: widget.onPressed,
                      )).show().then((value) {
                    if (value == null) {
                    } else {
                      // Navigator.pop(context, value);
                    }
                  });
                }),
          ],
        );

      case 'approved':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [DeclineButton()],
        );
      case 'declined':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomGradientElevatedButton(
                height: 40,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Confirm',
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
                      title: 'អូនស្រលាញ់បងអត់ ?',
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
                          'ទេ',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          // Navigator.pop(context);
                        },
                      ),
                      btnOk: CustomGradientElevatedButton(
                        height: 40,
                        child: Text(
                          'បាទ / ចាស់',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: widget.onPressed,
                      )).show().then((value) {
                    if (value == null) {
                    } else {
                      // Navigator.pop(context, value);
                    }
                  });
                }),
          ],
        );
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        'Or',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      radius: 35,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Or Mengley',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.phone,
                                size: 20,
                              ),
                              Text(
                                '098943324',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.mail,
                                size: 20,
                              ),
                              Text(
                                ' mengley.developer@gmail.com',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 20,
                              ),
                              Expanded(
                                child: Text(
                                  'Battambang Province, Battambang District, Peaek Moha Tep Village, Svay Por Commune',
                                  maxLines: 3,
                                  style: TextStyle(fontSize: 15),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    getStatusIcon(widget.status)
                  ],
                ),
                Expanded(flex: 1, child: Container()),
                getStatusButton(widget.status)
              ],
            ),
          ),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400, spreadRadius: 1, blurRadius: 10.0)
          ], color: Colors.white, borderRadius: BorderRadius.circular(14.0)),
        ),
        Positioned.fill(
          bottom: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  highlightColor: Colors.white,
                  overlayColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color.fromARGB(255, 198, 255, 200)
                          .withOpacity(0.2);
                    }
                    return Colors.white;
                  }),
                  splashFactory: InkSplash.splashFactory,
                  splashColor:
                      const Color.fromARGB(255, 45, 255, 52).withOpacity(0.1),
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                WholesaleRequestDetailScreen(
                                    status: widget.status)));
                  }),
            ),
          ),
        )
      ],
    );
  }

  Widget buildText(String title, String value) {
    return Text(
      '$title ៖ $value',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 13),
    );
  }
}
