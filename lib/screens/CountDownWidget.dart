import 'package:flutter/widgets.dart';

///Class to build CountDown widget.

class CountDownWidget extends AnimatedWidget {
  CountDownWidget({Key key, this.animation}) : super(key: key, listenable: animation);

  final Animation<int> animation;

  @override
  Widget build(BuildContext context) {
    return Text(
      '(Resend after ' + animation.value.toString() + ' seconds)',
      style: TextStyle(fontSize: 14.0),
    );
  }
}
