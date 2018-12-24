import 'package:feel_good/api/deeds_api.dart';
import 'package:feel_good/model/deed.dart';
import 'package:feel_good/widget/deed_stack_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  Future<List<Deed>> _deeds;

  @override
  void initState() {
    super.initState();
    _deeds = fetchDeeds();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.amber,
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: SizedBox(
                height: 200,
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 100, maxWidth: 300),
                    child: Image.asset("images/feel_good.png"),
                  ),
                ),
              ),
            ),
            Center(
              child: FutureBuilder<List<Deed>>(
                  future: _deeds,
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return DeedStackWidget(deeds: snapshot.data);
                    else if (snapshot.hasError)
                      return Text(snapshot.error.toString()); // TODO Style
                    else
                      return CircularProgressIndicator(); // TODO Style
                  }),
            )
          ],
        ),
      );
}
