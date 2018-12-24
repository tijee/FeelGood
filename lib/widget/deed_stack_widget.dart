import 'dart:collection';
import 'dart:math';

import 'package:feel_good/model/deed.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DeedStackWidget extends StatefulWidget {
  final List<Deed> deeds;

  DeedStackWidget({Key key, @required this.deeds}) : super(key: key);

  @override
  _DeedStackState createState() => _DeedStackState(deeds);
}

class _DeedStackState extends State<DeedStackWidget> {
  List<_DeedViewModel> _deeds;

  _DeedStackState(List<Deed> deeds) : super() {
    _deeds = List.unmodifiable(
        deeds?.map((deed) => _DeedViewModel.fromDeed(deed)) ?? []);
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 300.0,
        height: 400.0,
        child: Stack(
          children: _deeds
              .map((deed) => Dismissible(
                    key: Key(deed.uniqueId),
                    child: _DeedWidget(deed: deed),
                    onDismissed: (_) => _onDismissDeed(),
                  ))
              .toList(growable: false),
        ),
      );

  /// Rotates the deeds collection:
  /// pops the last item, copies it in a new item
  /// (so its uuid is not the same and it is considered as a new Dismissible)
  /// and adds it in first position.
  void _onDismissDeed() {
    setState(() {
      var rotatedDeeds = ListQueue.from(_deeds);
      var topDeed = rotatedDeeds.removeLast();
      var newFirstDeed =
          _DeedViewModel(text: topDeed.text, angle: topDeed.angle);
      rotatedDeeds.addFirst(newFirstDeed);
      _deeds = List.unmodifiable(rotatedDeeds);
    });
  }
}

class _DeedWidget extends StatelessWidget {
  final _DeedViewModel deed;

  _DeedWidget({Key key, @required this.deed}) : super(key: key);

  @override
  Widget build(BuildContext context) => Transform.rotate(
        angle: deed.angle,
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          child: Padding(
            padding: EdgeInsets.all(36.0),
            child: Center(
              child: FittedBox(
                child: Text(
                  deed.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 50.0, fontFamily: "Halogen"),
                ),
              ),
            ),
          ),
        ),
      );
}

class _DeedViewModel {
  final String uniqueId = Uuid().v4();
  final String text;
  final double angle;

  _DeedViewModel({this.text, this.angle});

  factory _DeedViewModel.fromDeed(Deed deed) =>
      _DeedViewModel(text: deed.text, angle: _randomAngle());

  /// Generates a random angle between
  /// pi / 50 and pi / 100 (or negative).
  static double _randomAngle() {
    var random = Random();
    var angle = pi / (random.nextInt(50) + 50);
    return random.nextBool() ? angle : -angle;
  }
}
