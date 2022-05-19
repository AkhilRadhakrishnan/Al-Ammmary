import 'package:al_ammari/Models/media_model.dart';
import 'package:al_ammari/screens/youtube_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widget/gradient_icon.dart';
import '../provider/article_provider.dart';
import '../util/style_constants.dart';

class Video1 extends StatefulWidget {
  const Video1({Key? key}) : super(key: key);

  @override
  State<Video1> createState() => _Video1State();
}

class _Video1State extends State<Video1> {
  @override
  void initState() {
    super.initState();
    context.read<AllProvider>().fetchVideo();
  }

  dynamic videoClicked;

  String dropdownvalue = 'اختر الفئة';

  // List of items in our dropdown menu
  var items = [
    'اختر الفئة',
    'مكة',
    'مدينة',
  ];

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
              GradientIcon(Icons.video_collection, 30.0),
              Text(
                'فيديو',
                style: TextStyle(
                    fontSize: 20.0,
                    foreground: Paint()..shader = linearGradient),
              ),
            ],
          )),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.4,
                child: DropdownButton(
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: GradientIcon(Icons.keyboard_arrow_down, 25.0),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: TextStyle(
                            fontSize: 20.0,
                            foreground: Paint()..shader = linearGradient),
                      ),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            ],
          ),
          Consumer<AllProvider>(builder: (context, value, child) {
            List<Media>? items;
            if (value.media == null) {
          return const Center(child: CircularProgressIndicator());
            }
            if (value.media!.media != null) {
          items = value.media!.media!;
          if (dropdownvalue != 'اختر الفئة') {
            items = items
                .where((x) => x.category!.contains(dropdownvalue))
                .toList();
          }
            }
            return Column(
          children: [
            if (videoClicked != null)
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: AlAmmariYoutubePlayer(video: videoClicked),
              ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(bottom: 5),
                height: MediaQuery.of(context).size.height * (videoClicked == null ? 0.75 : 0.45),
                child: ListView.separated(
                  itemCount: items!.length,
                  itemBuilder: (context, index) {
                    var video = items!.elementAt(index);
                    return InkWell(
                        child:
                            Stack(alignment: Alignment.center, children: [
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: NetworkImage(
                                video.bannerimage!,
                              ),
                              fit: BoxFit.fill,
                            )),
                          ),
                          const SizedBox(
                            height: 50,
                            child: Icon(
                              Icons.play_arrow_rounded,
                              size: 50,
                              color: Colors.black54,
                            ),
                          )
                        ]),
                        onTap: () {
                          setState(() {
                            videoClicked = video;
                          });
                        });
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                        height: 10, thickness: 2, color: primaryColor);
                  },
                ),
              ),
            ),
          ],
            );
          }),
        ],
      ),
    );
  }
}
