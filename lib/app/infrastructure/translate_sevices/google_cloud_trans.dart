import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../auth_keys/api_keys.dart';

class TranslationServices {
  static Future<String> translate(
      {required String text, required String language}) async {
    var uri = Uri.parse(
        'https://translation.googleapis.com/language/translate/v2?target=${language}&key=${google_translator_api}&q=${text}');

    var response = await http.post(uri);
    final Map<String, dynamic> decodedData = jsonDecode(response.body);
    /* print(decodedData); */

    return decodedData['data']['translations'][0]['translatedText'];
  }
}
