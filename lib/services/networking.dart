import 'package:http/http.dart' as http;
import 'dart:convert';

class myNetwork{
  final String url;

  myNetwork(this.url);
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    var data = response.body;

    return jsonDecode(data);
  }

}