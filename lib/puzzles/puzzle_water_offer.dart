import 'package:flutter/material.dart';
import 'package:mayan_level1/managers/game_state_manager.dart';
import 'package:provider/provider.dart';

class WaterPuzzle extends StatefulWidget {
  final VoidCallback onSolved;

  const WaterPuzzle({required this.onSolved, super.key});

  @override
  _WaterPuzzleState createState() => _WaterPuzzleState();
}

class _WaterPuzzleState extends State<WaterPuzzle>
    with SingleTickerProviderStateMixin {
  bool isFilled = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void fillBowl() {
    setState(() {
      isFilled = true;
    });
    _controller.forward(); // Start fade animation
    Future.delayed(Duration(seconds: 1), () {
      final gameState = context.read<GameStateManager>();
      gameState.markPuzzleAsSolved('water_offering');
      gameState.collectItem('Hidden Passage Key');
      widget.onSolved();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasWaterVessel =
        context.watch<GameStateManager>().hasItem("Water Basin");

    return AlertDialog(
      title: Text("Water Offering Puzzle"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/icons/water_basin.png', width: 80),
              if (isFilled)
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Image.asset(
                    'assets/icons/glow.png', // glow overlay image
                    width: 140,
                  ),
                ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            isFilled
                ? "The bowl is now full! You found a key!"
                : "Pour water into the bowl to reveal the hidden key.",
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: hasWaterVessel && !isFilled ? fillBowl : null,
            child: Text("Pour Water"),
          ),
        ],
      ),
    );
  }
}

//PuzzleWaterOffer
