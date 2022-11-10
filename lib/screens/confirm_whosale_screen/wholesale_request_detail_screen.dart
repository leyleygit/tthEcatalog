import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecatalog/components/custom_gradient_elevated_button.dart';
import 'package:ecatalog/components/decline_button.dart';
import 'package:ecatalog/data/image_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WholesaleRequestDetailScreen extends StatefulWidget {
  final String status;
  const WholesaleRequestDetailScreen({
    super.key,
    required this.status,
  });

  @override
  State<WholesaleRequestDetailScreen> createState() =>
      _WholesaleRequestDetailScreenState();
}

class _WholesaleRequestDetailScreenState
    extends State<WholesaleRequestDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int activeIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            splashRadius: 25.0,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.clear,
              color: Colors.black,
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: getStatus(widget.status),
              ),
            )
          ],
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
        SliverToBoxAdapter(
          child: CarouselSlider.builder(
              itemCount: imgListUrl.length,
              itemBuilder: (context, index, realIndex) {
                final imgUrl = imgListUrl[index];
                return buildSlideImage(imgUrl, index);
              },
              options: CarouselOptions(
                  height: 400,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  //enlargeStrategy: CenterPageEnlargeStrategy.height

                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  })),
        ),
        SliverToBoxAdapter(
          child: Container(
            //color: Colors.amber,
            height: 20,
            child: Center(child: buildIndicator()),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 30,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildText('Name', 'Or Mengley'),
                  buildText('Phone number', '098943324'),
                  buildText('Email', 'mengley.develoepr@gmail.com'),
                  buildText('Province or City', 'Battambang'),
                  buildText('District', 'Battambang'),
                  buildText('Village or Commune', 'Svay Por Commune'),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [getStatusButton(widget.status)],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ]),
          ),
        )
      ]),
    );
  }

  Widget buildText(String fieldName, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$fieldName :',
            style: TextStyle(fontSize: 17, color: Colors.grey),
          ),
          Expanded(
            child: Text(
              ' $value',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSlideImage(String imgUrl, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        decoration:
            BoxDecoration(image: DecorationImage(image: NetworkImage(imgUrl))),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
      effect: WormEffect(
          activeDotColor: Colors.green, dotHeight: 10.0, dotWidth: 10.0),
      activeIndex: activeIndex,
      count: imgListUrl.length);
  getStatus(String status) {
    switch (status) {
      case 'request':
        return const SizedBox();
      case 'approved':
        return Text(
          'Approved',
          style: TextStyle(color: Colors.green, fontSize: 18),
        );
      case 'declined':
        return Text(
          'Declined',
          style: TextStyle(color: Colors.red, fontSize: 18),
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
                        onPressed: () {},
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
                        onPressed: () {},
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
}
