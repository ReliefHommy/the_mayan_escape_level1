import 'package:flutter/material.dart';

class PuzzlePopup extends StatefulWidget {
  final String puzzleTitle;
  final VoidCallback onClose;

  const PuzzlePopup(
      {required this.puzzleTitle, required this.onClose, super.key});

  @override
  _PuzzlePopupState createState() => _PuzzlePopupState();
}

class _PuzzlePopupState extends State<PuzzlePopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _opacity = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        width: 300,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          //color: Colors.orangeAccent.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.puzzleTitle,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            SizedBox(height: 20),
            Text("Solve this puzzle to progress!",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: widget.onClose,
              child: Text("Close"),
            ),
          ],
        ),
      ),
    );
  }
}
