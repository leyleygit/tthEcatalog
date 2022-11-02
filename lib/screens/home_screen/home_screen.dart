import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:ecatalog/data/catalogData.dart';
import 'package:ecatalog/pdfs/pdfView_Screen.dart';
import 'package:ecatalog/screens/search_screen/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dateValue = DateTime.now();

  Future<File> createFileOfPdfUrl() async {
    //function pdf preview
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      final url = "https://www.africau.edu/images/default/sample.pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      print("completed");
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }

  viewPdf() {
    createFileOfPdfUrl().then((filePDF) {
      if (filePDF.path != "") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PDFScreen(path: filePDF.path)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        //backgroundColor: Color(0xffFBFDF7),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (BuildContext context) =>
                                    SearchScreen()));
                      },
                      splashRadius: 25,
                      icon: const Icon(
                        CupertinoIcons.search,
                        color: Colors.black,
                      )),
                )
              ],
              leading: IconButton(
                splashRadius: 25,
                icon: const Icon(
                  CupertinoIcons.back,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              elevation: 0,
              floating: true,
              backgroundColor: Colors.white,
            ),
            buildYearsDisplay('Choose your spacial \nEcatalog'),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    child: buildBookCatalog(index, size),
                  );
                },
                childCount: listCatalogs.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 0,
                  childAspectRatio: 2.0,
                  mainAxisExtent: 500),
            ),
          ],
        ));
  }

  Widget buildBookCatalog(int index, size) {
    return Stack(
      children: [
        Container(
          height: 500,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  image: AssetImage(listCatalogs[index].imgPath)),
              borderRadius: BorderRadius.circular(3.0),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10.0,
                    color: Colors.grey.shade500)
              ],
              color: Colors.white),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 3.0,
                  sigmaY: 3.0,
                ),
                child: Container(
                  height: 100,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(3.0),
                          bottomRight: Radius.circular(3.0))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            listCatalogs[index].title,
                            style: const TextStyle(
                                letterSpacing: 2.0,
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.clock_fill,
                                color: Color.fromARGB(255, 255, 177, 60),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                Jiffy(dateValue).format('dd  MMMM  yyy'),
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                              )
                            ],
                          )
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
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
                  onTap: viewPdf),
            ),
          ),
        )
      ],
    );
  }

  Widget buildYearsDisplay(String? text) {
    return SliverToBoxAdapter(
      child: Container(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(children: [
            Text(
              text!,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            )
          ]),
        ),
      ),
    );
  }
}
