import 'package:feel_good/page/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(new FeelGoodApp());

class FeelGoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Feel Good',
        home: HomePage(),
      );
}
