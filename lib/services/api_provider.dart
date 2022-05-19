import 'dart:convert';
import 'package:al_ammari/Models/media_model.dart';
import 'error_handling.dart';
import 'network.dart';
import 'package:http/http.dart' as http;

class ApiProvider {

  static const baseUrl = "https://alammary.co/api/";

  Network auth = Network();


  Future<MediaModel?> getBook() async {
    try {
      http.Response response = await auth.getRequest(url: baseUrl + "Books/Books_get/book");
      if (response.statusCode == 200) {
        return MediaModel.fromJson(json.decode(response.body));
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
    return null;
  }

  Future<MediaModel?> getArticle() async {
    try {
      http.Response response = await auth.getRequest(url: baseUrl + "Article/Article_get");
      if (response.statusCode == 200) {
        return MediaModel.fromJson(json.decode(response.body));
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
    return null;
  }

  Future<MediaModel?> getVideo() async {
    try {
      http.Response response = await auth.getRequest(url: baseUrl + "Books/Books_get/video");
      if (response.statusCode == 200) {
        return MediaModel.fromJson(json.decode(response.body));
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
    return null;
  }

  Future<MediaModel?> getAudio() async {
    try {
      http.Response response = await auth.getRequest(url: baseUrl + "Books/Books_get/audio");
      if (response.statusCode == 200) {
        return MediaModel.fromJson(json.decode(response.body));
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
    return null;
  }

  validateContact({data}) async {
    try {
      http.Response response = await auth.postRequest(
          url: baseUrl + "Contact_us/contact_post", data: data);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return errorHandling(response.statusCode);
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
  }
}