import 'dart:convert';
import 'package:http/http.dart' as http;

class Network {
  //Implementing Singleton Class
  // static final Network _network = Network._internal();
  // factory Network() => _network;
  // Network._internal(); // Private Constructor

  Map<String, String>? _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  getRequest({url}) async {
    var fullUrl = Uri.parse(url);
    return await http.get(fullUrl, headers: _setHeaders());
  }

  postRequest({url, data}) async {
    var fullUrl = Uri.parse(url);
    return await http.post(fullUrl,
        headers: _setHeaders(), body: jsonEncode(data));
  }


}
