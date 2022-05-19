import 'package:al_ammari/screens/vdo_player.dart';
import 'package:al_ammari/screens/videos.dart';
import 'package:al_ammari/util/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Widget/gradient_icon.dart';
import 'ContactUs.dart';
import 'audio.dart';
import 'book.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var timeString = '';
  var dateString = "";
  @override
  void initState() {
    initializeDateFormatting();
    var timeFormat = DateFormat.jm('ar');
    timeString = timeFormat.format(DateTime.now());
    var dateFormat = DateFormat.yMMMEd('ar');
    dateString = dateFormat.format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: GradientIcon(Icons.menu_book, 25.0),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Contact()));
            }),
        title: Padding(
          padding: const EdgeInsets.all(100.0),
          child: Text(" ",
              style: TextStyle(
                  fontSize: 25.0,
                  foreground: Paint()..shader = linearGradient)),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: primaryColor,
                image: DecorationImage(
                  image: AssetImage('assets/layout.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                      timeString,
                        style: TextStyle(
                            fontSize: 55.0,
                            foreground: Paint()..shader = linearGradient),
                      ),
                    ],
                  ),
                  Text(
                    dateString,
                    style: TextStyle(
                        fontSize: 25.0,
                        foreground: Paint()..shader = linearGradient),
                  ),
                ],
              ),
            ),
            // Ink(height: 5,color: primaryColor),
            Container(
              padding:
                  EdgeInsets.only(top: 10, bottom: 15, left: 25, right: 25),
              color: primaryColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 1.25,
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Book(isBook: false)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              height: 100,
                              child: Image.asset(
                                'assets/prayer.png',
                                fit: BoxFit.cover,
                              )),
                          Text(
                            'مقالة',
                            style: TextStyle(
                                fontSize: 20.0,
                                foreground: Paint()..shader = linearGradient),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Book(isBook: true)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              height: 100,
                              child: Image.asset(
                                'assets/book.png',
                                fit: BoxFit.cover,
                              )),
                          Text(
                            'الكتب',
                            style: TextStyle(
                                fontSize: 20.0,
                                foreground: Paint()..shader = linearGradient),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Audio()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GradientIcon(Icons.audiotrack, 50.0),
                          Text(
                            'صوتي',
                            style: TextStyle(
                                fontSize: 20.0,
                                foreground: Paint()..shader = linearGradient),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Video()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GradientIcon(Icons.video_collection, 50.0),
                          Text(
                            'فيديو',
                            style: TextStyle(
                                fontSize: 20.0,
                                foreground: Paint()..shader = linearGradient),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
