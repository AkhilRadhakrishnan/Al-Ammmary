import 'package:al_ammari/Widget/book_card.dart';
import 'package:al_ammari/provider/article_provider.dart';
import 'package:flutter/material.dart';
import '../Widget/gradient_icon.dart';
import '../util/style_constants.dart';
import 'package:provider/provider.dart';

class Book extends StatefulWidget {
  bool isBook;
  Book({Key? key, required this.isBook}) : super(key: key);

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  String dropdownvalue = 'اختر الفئة';

  // List of items in our dropdown menu
  var items = ['اختر الفئة', 'مكة', 'مدينة'];

  @override
  void initState() {
    super.initState();
    if (widget.isBook) {
      context.read<AllProvider>().fetchBook();
    } else {
      context.read<AllProvider>().fetchArticle();
    }
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
              Text(widget.isBook?"الكتب":"مقالة",
                  style: TextStyle(
                      fontSize: 25.0,
                      foreground: Paint()..shader = linearGradient)),
            ],
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            widget.isBook?SizedBox(
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
            ):SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15.0),
              child: Container(
                padding: EdgeInsets.all(10),
                // color: secondaryColor.withOpacity(.9),
                // color: primaryColor.withOpacity(.9),
                decoration: const BoxDecoration(
                    color: primaryColor,
                    image: DecorationImage(
                        opacity: 0.2,
                        image: AssetImage('assets/mecca.jpg'),
                        fit: BoxFit.cover)),
                height: MediaQuery.of(context).size.height * (widget.isBook? 0.77:0.85),
                child: Consumer<AllProvider>(builder: (context, value, child) {
                  var items = value.media?.media;
                  if (items == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (items != null && dropdownvalue != 'اختر الفئة') {
                    items = items
                        .where((x) => x.category!.contains(dropdownvalue))
                        .toList();
                  }
                  return GridView.builder(
                      itemCount: items.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () async {},
                            child: BookPage(
                              isBook: widget.isBook,
                              book: items!.elementAt(index),
                            ));
                      });
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
