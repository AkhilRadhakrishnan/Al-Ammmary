import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../Widget/gradient_icon.dart';
import '../util/style_constants.dart';

class BookView extends StatefulWidget {
  String? pdf;
  BookView({Key? key, required this.pdf}) : super(key: key);

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: GradientIcon(Icons.arrow_back_ios, 25.0),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: primaryColor,
          elevation: 4,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientIcon(Icons.menu_book, 25.0),
              Text(
                'فيديو',
                style: TextStyle(
                    fontSize: 20.0,
                    foreground: Paint()..shader = linearGradient),
              ),
            ],
          )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SfPdfViewer.network(
          widget.pdf!,
          key: _pdfViewerKey,
          canShowScrollHead: true,
        ),
      ),
    );
  }
}
