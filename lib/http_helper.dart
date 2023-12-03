import 'package:http/http.dart' as http;

class HttpHelper {
  String url = 'https://bengkelkoding.dinus.ac.id/food/';
  Future<http.Response> getAPI() async {
    final response =
        await http.get(Uri.parse('https://bengkelkoding.dinus.ac.id/food/'));
    return response;
  }
}
