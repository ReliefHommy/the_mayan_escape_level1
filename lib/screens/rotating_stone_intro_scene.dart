import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mayan_level1/text_style.dart';

//RotatingStoneIntroScene

class RotatingStoneIntroScene extends StatefulWidget {
  final VoidCallback onContinue;
  //

//

  const RotatingStoneIntroScene({super.key, required this.onContinue});

  @override
  State<RotatingStoneIntroScene> createState() =>
      _RotatingStoneIntroSceneState();
}

class _RotatingStoneIntroSceneState extends State<RotatingStoneIntroScene> {
  final List<String> storyLines = [
    "In the center stands a colossal stone disk, carved with fading Mayan glyphs.",
    "The dial must be turned — but only the correct alignment will awaken the path forward.",
  ];

  int _currentLine = 0;
  String _displayedText = "";
  Timer? _typingTimer;
  int _charIndex = 0;
  bool _isTyping = false;

  void _startTyping() {
    setState(() {
      _displayedText = "";
      _charIndex = 0;
      _isTyping = true;
    });

    _typingTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (_charIndex < storyLines[_currentLine].length) {
        setState(() {
          _displayedText += storyLines[_currentLine][_charIndex];
          _charIndex++;
        });
      } else {
        timer.cancel();
        setState(() {
          _isTyping = false;
        });
      }
    });
  }

  void _nextLine() {
    if (_currentLine < storyLines.length - 1) {
      _currentLine++;
      _startTyping();
    }
  }

  @override
  void dispose() {
    _typingTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background  desktop
          Positioned.fill(
            child: Image.asset(
              'assets/images/temple_entrance.jpg', // your decorative image
              fit: BoxFit.cover,
            ),
          ),
          //Background scens
          Positioned.fill(
              child: Center(
                  child: SizedBox(
            width: 500,
            child: Image.asset(
              'assets/images/temple_entrance.jpg',
              fit: BoxFit.cover,
            ),
          ))),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.1)),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Spacer(
                    flex: 6,
                  ),
                  Text(
                    _displayedText,
                    style: subHeadingTextStyle,
                  ),
                  const SizedBox(height: 40),
                  if (!_isTyping && _currentLine < storyLines.length - 1)
                    ElevatedButton(
                      onPressed: _nextLine,
                      child: Text(
                        "Continue",
                        style: elevatedButtonTextStyle,
                      ),
                    ),
                  if (!_isTyping && _currentLine == storyLines.length - 1)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/entrance');
                      },
                      child: Text(
                        "Tap to Begin Puzzle",
                        style: elevatedButtonTextStyle,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
