import 'package:flutter/material.dart';

final Color light = Color(0xFFfff6f5);
final Color purple = Color(0xFF58409d);
final Color pink = Color(0xFFfba5ae);
final Color yellow = Color(0xFFfcd07a);

class MultipleAnimationScree extends StatefulWidget {
  @override
  _MultipleAnimationScreeState createState() => _MultipleAnimationScreeState();
}

class _MultipleAnimationScreeState extends State<MultipleAnimationScree>
    with TickerProviderStateMixin {
  AnimationController _firstController;
  AnimationController _secondController;
  AnimationController _thirdController;

  Animation<Color> _firstColorAnim;
  Animation<Color> _secondColorAnim;
  Animation<Color> _thirdColorAnim;

  static final firstColorTween = ColorTween(begin: purple, end: yellow);
  static final secondColorTween = ColorTween(begin: purple, end: yellow);
  static final thirdColorTween = ColorTween(begin: purple, end: yellow);

  @override
  void initState() {
    super.initState();

    _firstController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _secondController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _thirdController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _firstColorAnim = firstColorTween.animate(_firstController);
    _secondColorAnim = secondColorTween.animate(_secondController);
    _thirdColorAnim = thirdColorTween.animate(_thirdController);
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: AnimatedBuilder(
                  animation: _firstColorAnim,
                  builder: (context, child) => Container(
                    color: _firstColorAnim.value,
                  ),
                ),
              ),
              Expanded(
                child: AnimatedBuilder(
                  animation: _secondColorAnim,
                  builder: (context, child) => Container(
                    color: _secondColorAnim.value,
                  ),
                ),
              ),
              Expanded(
                child: AnimatedBuilder(
                  animation: _thirdColorAnim,
                  builder: (context, child) => Container(
                    color: _thirdColorAnim.value,
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
                onTap: () async {
                  if (_firstController.isCompleted) {
                    await _firstController.reverse();
                    await _secondController.reverse();
                    await _thirdController.reverse();
                  } else {
                    await _thirdController.forward();
                    await _secondController.forward();
                    await _firstController.forward();
                  }
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
        child: Center(
          child: Text("Animate"),
        ),
      ),
    );
  }
}
