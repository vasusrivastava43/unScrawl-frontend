import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class APIAnimation extends StatelessWidget {
  APIAnimation({Key? key}) : super(key: key);

  final RiveAnimationController _controller = SimpleAnimation('idle');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RiveAnimation.asset(
        'assets/rive/panda.riv',
        controllers: [_controller],
      ),
    );
  }
}
