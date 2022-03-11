import 'dart:convert';
import 'package:get/get.dart';
import 'package:pomoc_ukrainie/helpers/theme/alert_styles.dart';

import '../../auth_keys/api_keys.dart';

import 'package:http/http.dart' as http;

class TranslationServices {
  static Future<String> translate(
      {required String text, required String language}) async {
    var uri = Uri.parse(
        'https://translation.googleapis.com/language/translate/v2?target=${language}&key=${google_translator_api}&q=${text}');

    var response = await http.post(uri).catchError((onError)=>print(onError));
    final Map<String, dynamic> decodedData = jsonDecode(response.body);

    return decodedData['data']['translations'][0]['translatedText'];
  }
}
