import 'package:flutter/material.dart';

final Color light = Color(0xFFfff6f5);
final Color purple = Color(0xFF58409d);
final Color pink = Color(0xFFfba5ae);
final Color yellow = Color(0xFFfcd07a);

class TweenAnimationScreen extends StatefulWidget {
  @override
  _TweenAnimationScreenState createState() => _TweenAnimationScreenState();
}

class _TweenAnimationScreenState extends State<TweenAnimationScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colorAnim;
  Animation<Decoration> _shapeAnim;

  static final pty = ColorTween(begin: purple, end: yellow);
  static final ytp = ColorTween(begin: yellow, end: purple);
  static final ppty = ColorTween(begin: purple, end: pink);

  static final shape = DecorationTween(
    begin: BoxDecoration(
      borderRadius: BorderRadius.circular(1000),
      color: purple,
    ),
    end: BoxDecoration(
      borderRadius: BorderRadius.zero,
      color: purple,
    ),
  );

  static final seq = TweenSequence<Color>([
    TweenSequenceItem(tween: pty, weight: 1),
    TweenSequenceItem(tween: ytp, weight: 1),
    TweenSequenceItem(tween: ppty, weight: 1),
  ]);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _colorAnim = seq.animate(_controller);
    _shapeAnim = shape.animate(_controller);
  }

  @override
  void dispose() {
    // don't forget to clean up!
    _controller.dispose();
    super.dispose();
  }

  // Our build method will go here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) => Container(
                    color: _colorAnim.value,
                  ),
                ),
              ),
              Expanded(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) => Container(
                    decoration: _shapeAnim.value,
                  ),
                ),
              ),
              Expanded(
                child: TweenAnimationBuilder<Color>(
                  curve: Curves.ease,
                  duration: Duration(seconds: 3),
                  tween: ColorTween(begin: yellow, end: purple),
                  builder: (context, Color color, child) => Container(
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  print('Tapped');
                  if (_controller.isCompleted)
                    _controller..reverse();
                  else
                    _controller..forward();
                },
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
