import 'dart:io';
import 'dart:math';
import 'package:al_ammari/Models/media_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../screens/article_view.dart';
import '../screens/book_view.dart';
import '../util/style_constants.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BookPage extends StatelessWidget {
  final bool isBook;
  final Media book;
  final fileUrl =
      "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
  final dio = Dio();

  BookPage({Key? key, required this.book, required this.isBook});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(2),
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 8,
            child: Container(
              margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
              // width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: secondaryColor,
                ),
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    book.bannerimage!,
                  ),
                ),
                // borderRadius: BorderRadius.circular(00),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.topCenter,
              child: Text(
                book.title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // TextButton(
              //     onPressed: () async {
              //       var tempDir = await getTemporaryDirectory();
              //       String fullPath = tempDir.path + "/boo2.pdf'";
              //       // downloadPdf(dio, fileUrl, fullPath);
              //       downloadFile(fileUrl, 'test.pdf', fullPath);
              //     },
              //     child: const Text('تحميل',
              //         style: TextStyle(color: primaryColor))),
              ElevatedButton(
                  onPressed: () {
                    if (isBook) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookView(pdf: book.file)));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ArticleView(article: book)));
                    }
                  },
                  child: Text('إقرأ المزيد',
                      style: TextStyle(
                          fontSize: 12.0,
                          foreground: Paint()..shader = linearGradient)),
                  style:
                      elevatedButton(MediaQuery.of(context).size.width * 0.25)),
            ],
          )
        ],
      ),
    );
  }

  Future<String> downloadFile(String url, String fileName, String dir) async {
    HttpClient httpClient = new HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = url+'/'+fileName;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if(response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$dir/$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      }
      else
        filePath = 'Error code: '+response.statusCode.toString();
    }
    catch(ex){
      filePath = 'Can not fetch url';
    }

    return filePath;
  }

  // downloadPdf(Dio dio, String url, String savePath) async {
  //   try {
  //     Response response = await dio.get(
  //       url,
  //       onReceiveProgress: showDownloadProgress,
  //       //Received data with List<int>
  //       options: Options(
  //           responseType: ResponseType.bytes,
  //           followRedirects: false,
  //           validateStatus: (status) {
  //             return status! < 500;
  //           }),
  //     );
  //     debugPrint(response.headers.toString());
  //     File file = File(savePath);
  //     var raf = file.openSync(mode: FileMode.write);
  //     // response.data is List<int> type
  //     raf.writeFromSync(response.data);
  //     await raf.close();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      debugPrint((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
}
