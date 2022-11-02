import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:ecatalog/model/catalog_model.dart';
import 'package:ecatalog/data/catalogData.dart';
import 'package:ecatalog/pdfs/pdfView_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FocusNode searchFocus = FocusNode();
  bool isFocus = false;
  BehaviorSubject<List<CatalogModel>> subjectTmpCatalogs =
      BehaviorSubject<List<CatalogModel>>();

  TextEditingController searchCatalogController = TextEditingController();
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

  viewPDF() {
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
  void initState() {
    super.initState();
    // searchFocus.requestFocus();
    subjectTmpCatalogs.add(listCatalogs);
  }

  @override
  void dispose() {
    searchCatalogController.dispose();
    subjectTmpCatalogs.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        searchFocus.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            floating: true,
            toolbarHeight: 100.0,
            title: SizedBox(
              height: 40,
              child: TextField(
                  controller: searchCatalogController,
                  focusNode: searchFocus,
                  onChanged: (value) {
                    subjectTmpCatalogs.add(listCatalogs
                        .where((e) => e.title
                            .trim()
                            .toLowerCase()
                            .contains(value.toString().trim().toLowerCase()))
                        .toList());
                  },
                  decoration: InputDecoration(
                    hintText: 'search',
                    contentPadding: EdgeInsets.only(bottom: 10),
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: searchFocus.hasFocus ? Colors.green : Colors.grey,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.green)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.grey)),
                  )),
            ),
            leading: IconButton(
              splashRadius: 25.0,
              icon: const Icon(CupertinoIcons.clear, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
          ),
          StreamBuilder<List<CatalogModel>>(
              initialData: const <CatalogModel>[],
              stream: subjectTmpCatalogs,
              builder: (context, AsyncSnapshot snapshot) {
                List<CatalogModel> snapData = snapshot.data;
                if (snapshot.data == null) {
                  return const CircularProgressIndicator();
                }
                return SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (
                      context,
                      index,
                    ) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: searchFocus.hasFocus ? 10 : 30,
                            horizontal: searchFocus.hasFocus ? 10 : 30),
                        child: buildBookCatalog(
                            viewPDF: () => viewPDF(),
                            index: index,
                            size: size,
                            snapData: snapData,
                            searchFocus: searchFocus),
                      );
                    },
                    childCount: snapData.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: searchFocus.hasFocus ? 2 : 1,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      childAspectRatio: 2.0,
                      mainAxisExtent: searchFocus.hasFocus ? 250 : 500),
                );
              }),
        ]),
      ),
    );
  }
}

Widget buildBookCatalog({
  required dynamic viewPDF,
  required int index,
  required Size size,
  required List<CatalogModel> snapData,
  required FocusNode searchFocus,
}) {
  return Stack(
    fit: StackFit.expand,
    children: [
      Container(
        // height: searchFocus.hasFocus ? 250 : 500,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
                image: AssetImage(snapData[index].imgPath)),
            borderRadius: BorderRadius.circular(3.0),
            boxShadow: [
              BoxShadow(
                  spreadRadius: searchFocus.hasFocus ? 1 : 1,
                  blurRadius: searchFocus.hasFocus ? 5 : 10,
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
                height: searchFocus.hasFocus ? 70 : 100,
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
                          snapData[index].title,
                          style: TextStyle(
                              letterSpacing: 2.0,
                              color: Colors.white,
                              fontSize: searchFocus.hasFocus ? 17 : 25,
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
                              Jiffy(DateTime.now()).format('dd  MMMM  yyy'),
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
                splashColor: Color.fromARGB(255, 45, 255, 52).withOpacity(0.1),
                onTap: viewPDF,
              )),
        ),
      )
    ],
  );
}
