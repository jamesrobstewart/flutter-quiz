import 'package:flutter/material.dart';
import 'dart:math';

class AnswerOverlay extends StatefulWidget {
  final bool _isCorrect;
  final VoidCallback _onTap;

  AnswerOverlay(this._isCorrect, this._onTap);

  @override
  State<StatefulWidget> createState() {
    return AnswerOverlayState();
  }
}

class AnswerOverlayState extends State<AnswerOverlay>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _iconAnimation = CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.elasticOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _iconAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: InkWell(
        onTap: () => widget._onTap(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Transform.rotate(
                angle: _iconAnimation.value * 2 * pi,
                child: Icon(
                  widget._isCorrect == true ? Icons.done : Icons.clear,
                  size: _iconAnimation.value * 80.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
            ),
            Text(
              widget._isCorrect == true ? "Correct!" : "Wrong",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ],
        ),
      ),
    );
  }
}
