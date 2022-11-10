import 'package:ecatalog/pdfs/pdfView_Screen.dart';
import 'package:ecatalog/screens/confirm_whosale_screen/wholesale_request_screen.dart';
import 'package:ecatalog/screens/home_screen/home_screen.dart';
import 'package:ecatalog/webview/webview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WholesaleRequestScreen(),
    );
  }
}
