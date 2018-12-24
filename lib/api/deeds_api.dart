import 'dart:convert';

import 'package:feel_good/model/deed.dart';
import 'package:http/http.dart' as http;

Future<List<Deed>> fetchDeeds() async {
  final response = await http.get('https://thomasgallinari.com/feelgood/deeds');

  if (response.statusCode == 200) {
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((jsonObject) => Deed.fromJson(jsonObject))
        .toList(growable: false);
  } else {
    throw Exception('Failed to load deeds');
  }
}
