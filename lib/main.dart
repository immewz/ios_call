import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_call/shimmer_text.dart';

void main() {
  runApp(const MyCall());
}

class MyCall extends StatelessWidget {
  const MyCall({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IphoneCall(),
    );
  }
}

class IphoneCall extends StatelessWidget {
  const IphoneCall({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      body: const Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: SlideToAnswerSwitcher(),
          ),
        ],
      ),
    );
  }
}

class SlideToAnswerSwitcher extends StatefulWidget {
  const SlideToAnswerSwitcher({super.key});

  @override
  State<SlideToAnswerSwitcher> createState() => _SlideToAnswerSwitcherState();
}

class _SlideToAnswerSwitcherState extends State<SlideToAnswerSwitcher> {
  double height = 80;
  double _width = 400;
  double _padding = 5;
  late double _initialWidth;
  bool _hasAnswered = false;

  @override
  void initState() {
    super.initState();
    _initialWidth = _width;
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = _initialWidth / 6;
    return SafeArea(
      child: Container(
          width: _width,
          height: height,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 60),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white.withOpacity(0.3)),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(_padding),
          child: GestureDetector(
            onHorizontalDragEnd: _onDragEnd,
            onHorizontalDragUpdate: _onDragUpdate,
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: ShimmerText(
                    text: 'Slide To Answer',
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  width: buttonWidth,
                  child: const Icon(
                    CupertinoIcons.phone_fill,
                    color: Colors.green,
                    size: 35,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _onDragUpdate(DragUpdateDetails details) {
    double buttonWidth = _initialWidth / 6;
    double threshHold = buttonWidth + (_padding + 2);

    var distance = details.delta.distance;

    if (details.delta.dx > 0) {
      _width = max(
        _width - distance,
        threshHold,
      );
    } else {
      _width = min(
        _width + details.delta.distance,
        _initialWidth,
      );
    }

    setState(() {});
  }

  void _onDragEnd(DragEndDetails details) {
    var threshHold = (_initialWidth / 6) + (_padding * 2);
    if (_width > _initialWidth) return;
    if (_width == threshHold) {
      _hasAnswered = true;
    } else {
      _width = _initialWidth;
    }

    setState(() {
      print('Hold');
    });
  }
}
