import 'dart:async';

import 'package:flutter/material.dart';

class SimpleAnimationScreen extends StatefulWidget {
  @override
  _SimpleAnimationScreenState createState() => _SimpleAnimationScreenState();
}

class _SimpleAnimationScreenState extends State<SimpleAnimationScreen> {
  bool _isChanged = false;
  bool _longPressed = false;

  final controller = StreamController<int>();

  Stream<int> count() async* {
    int i = 1;
    Timer.periodic(Duration(seconds: 1), (timer) {
      controller.sink.add(++i);
    });
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    curve: Curves.ease,
                    color: _longPressed ? Colors.green : Colors.blue,
                    duration: Duration(seconds: 1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            LittleDot(longPressed: _longPressed),
                            LittleDot(longPressed: _longPressed),
                            LittleDot(longPressed: _longPressed),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: AnimatedContainer(
                    curve: Curves.easeInOutCirc,
                    color: _longPressed
                        ? Colors.white
                        : _isChanged
                            ? Colors.red
                            : Colors.blue,
                    duration: Duration(seconds: 1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            LittleDot(longPressed: _longPressed),
                            LittleDot(longPressed: _longPressed),
                            LittleDot(longPressed: _longPressed),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isChanged = !_isChanged;
                  });
                },
                onLongPress: () {
                  setState(() {
                    _longPressed = !_longPressed;
                  });
                },
                child: AnimatedContainer(
                  width: 100,
                  duration: Duration(seconds: 1),
                  height: 100,
                  decoration: BoxDecoration(
                    color: !_longPressed ? Colors.white : Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: _longPressed
                            ? Colors.white
                            : !_isChanged
                                ? Colors.green.shade400
                                : Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: Duration(seconds: 1),
                          style: TextStyle(
                            color: !_longPressed ? Colors.white : Colors.black,
                          ),
                          child: Text("Animate"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LittleDot extends StatelessWidget {
  const LittleDot({
    Key key,
    @required bool longPressed,
  })  : _longPressed = longPressed,
        super(key: key);

  final bool _longPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: _longPressed ? Colors.black : Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
