import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/media_model.dart';
import '../Widget/gradient_icon.dart';
import '../util/style_constants.dart';

class ArticleView extends StatelessWidget {
  final Media article;
  ArticleView({Key? key, required this.article}) : super(key: key);

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
              Text("مقالة",
                  style: TextStyle(
                      fontSize: 25.0,
                      foreground: Paint()..shader = linearGradient)),
            ],
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(article.image!),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(article.description!,
                style: TextStyle(
                  fontSize: 16.0,
                 ),),
            ),
          ],
        ),
      ),
    );
  }
}
