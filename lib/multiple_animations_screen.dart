import 'package:flutter/material.dart';

final Color light = Color(0xFFfff6f5);
final Color purple = Color(0xFF58409d);
final Color pink = Color(0xFFfba5ae);
final Color yellow = Color(0xFFfcd07a);

class MultipleAnimationScree extends StatefulWidget {
  @override
  _MultipleAnimationScreeState createState() => _MultipleAnimationScreeState();
}

class _MultipleAnimationScreeState extends State<MultipleAnimationScree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                child: BigDot(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BigDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: light,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
