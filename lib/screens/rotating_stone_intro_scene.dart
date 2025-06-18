import 'package:flutter/material.dart';
import 'package:mayan_level1/screens/exit_to_main.dart';
import 'dart:async';

import 'package:mayan_level1/text_style.dart';

//RotatingStoneIntroScene
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
            width: 700,
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
                      //
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade800.withOpacity(0.9),
                        foregroundColor: Colors.amberAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: const BorderSide(
                              color: Colors.amberAccent, width: 1.5),
                        ),
                        elevation: 6,
                        shadowColor: Colors.white,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'CinzelDecorative',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //

                      onPressed: _nextLine,
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontFamily: 'CinzelDecorative',
                          fontSize: 16,
                          color: Colors.amberAccent,
                        ),
                      ),
                    ),
                  if (!_isTyping && _currentLine == storyLines.length - 1)
                    ElevatedButton(
                      //
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade800.withOpacity(0.9),
                        foregroundColor: Colors.amberAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: const BorderSide(
                              color: Colors.amberAccent, width: 1.5),
                        ),
                        elevation: 6,
                        shadowColor: Colors.white,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'CinzelDecorative',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //
                      onPressed: () {
                        Navigator.pushNamed(context, '/entrance');
                      },
                      child: Text(
                        "Tap to Begin Puzzle",
                        style: TextStyle(
                          fontFamily: 'CinzelDecorative',
                          fontSize: 16,
                          color: Colors.amberAccent,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          ExitToMenuIcon(),
        ],
      ),
    );
  }
}
