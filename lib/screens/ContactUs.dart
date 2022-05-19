import 'package:al_ammari/screens/HomePage.dart';
import 'package:flutter/material.dart';

import '../Widget/gradient_icon.dart';
import '../services/repository.dart';
import '../util/style_constants.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _name, _mail, _subject,  _message;
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Card(

              child:  Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
              child:Column(
            children: [
              TextFormField(
                controller: name,
                validator: validateName,
                onSaved: (String? val) {
                  _name = val;
                },
                decoration: InputDecoration(
                  hintText: 'اسم',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(8),
                    width: 80,
                    child: Row(
                      children: [
                        GradientIcon(Icons.person, 25.0),
                      ],
                    ),
                  ),
                ),
              ),
              // TextFormField(
              //   controller: mobile,
              //   validator: validateMobile,
              //   onSaved: (String? val) {
              //     _mobile = val;
              //   },
              //   decoration: InputDecoration(
              //     hintText: 'جوال',
              //     filled: true,
              //     fillColor: Colors.white,
              //     prefixIcon: Container(
              //       padding: EdgeInsets.all(8),
              //       width: 80,
              //       child: Row(
              //         children: [
              //           GradientIcon(Icons.phone_android, 25.0),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              TextFormField(
                controller: mail,
                validator: validateEmail,
                onSaved: (String? val) {
                  _mail = val;
                },
                decoration: InputDecoration(
                  hintText: 'البريد الإلكتروني',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(8),
                    width: 80,
                    child: Row(
                      children: [
                        GradientIcon(Icons.mail, 25.0),
                      ],
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: subject,
                validator: validateName,
                onSaved: (String? val) {
                  _subject = val;
                },
                decoration: InputDecoration(
                  hintText: 'موضوع',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(8),
                    width: 80,
                    child: Row(
                      children: [
                        GradientIcon(Icons.subject, 25.0),
                      ],
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: message,
                validator: validateName,
                onSaved: (String? val) {
                  _message = val;
                },
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'موضوع',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(8),
                    width: 80,
                    child: Row(
                      children: [
                        GradientIcon(Icons.text_snippet_sharp, 25.0),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    _validateInputs();
                  },
                  child: Text('إرسال', style: TextStyle(
                      fontSize: 20.0, foreground: Paint()..shader = linearGradient),),
                  style: elevatedButton(MediaQuery.of(context).size.width * 0.25)),
              Text(
                'عنوان بريد الكتروني\ninfo@alammary.net',
                style: TextStyle(
                    fontSize: 20.0, foreground: Paint()..shader = linearGradient),
              )
            ],
          ))),
        ),
      ),
    );
  }
  contactUs()async {
    var data = {
      "name": name.text,
      "email": mail.text,
      "message": message.text,
      "subject":subject.text,

      // "password": "123456789"
    };
    dynamic res = await Repository().validateContact(data: data);
    if (res["status"]) {
      ScaffoldMessenger.of(context)
          .showSnackBar( SnackBar(
        content: Text(
          "شكرا لك على الاتصال بنا",
          style: const TextStyle(fontSize: 14),
        ),
        backgroundColor: primaryColor ,
        elevation: 5,
        duration: Duration(seconds:  3 ),
      ));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
              (route) => false);
    } else {
    }
  }//

  String? validateName(String? value) {
    if (value!.length < 3) {
      return 'يجب أن يتكون الحقل من أكثر من 3 أحرف';
    }
    return null;
  }

  String? validateMobile(String? value) {
    // String pattern = r'(^(?:[+0]9)?[0-9]{8}$)';
    // String pattern = r'^(([^(\d{8}(\,\d{8}){0,2}]))$';
    String pattern = r'(^(\d{8}(\,\d{8}){0,2})$)';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Please enter Valid Mobile number';
    }
    return null;
  }

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'الرجاء إدخال بريد إلكتروني صحيح';
    }
    return null;
  }

  void _validateInputs() {
    //If all data are correct then save data to out variables
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      contactUs();
    }
    _formKey.currentState!.save();
  }

}