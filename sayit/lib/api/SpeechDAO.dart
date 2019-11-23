import 'package:http/http.dart' as http;

const String url = "https://937f8a11.ngrok.io/api/FunctionGCP?code=yoEF7zHuThPdxN3plNi3o5ulUBXq8jSWFmp2rtwQLHBz1JkbRU2WCA==";

class SpeechDAO {
  static Future fetchAudioUrlAsync(String input) async {
    var response = await http.post(url, body: input);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return response.body;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to generate audio file');
    }
  }

  static Future fetchMp3Async(String url) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return response.body;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to fetch audio file');
    }
  } 
}