import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class bookViewer extends StatefulWidget{


  State<bookViewer> createState() => bookViewerState();
  bookViewer();
}

class bookViewerState extends State<bookViewer>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        child: SfPdfViewer.asset(
            "assets/sample.pdf")
        ));
  }
}