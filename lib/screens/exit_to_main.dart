import 'package:flutter/material.dart';

class ExitToMenuIcon extends StatelessWidget {
  const ExitToMenuIcon({super.key});

  void _confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.brown.shade900.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Exit to Main Menu?",
            style: TextStyle(
                fontFamily: 'CinzelDecorative', color: Colors.amberAccent)),
        content: const Text("Your progress will not be saved.",
            style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child:
                const Text("Exit", style: TextStyle(color: Colors.amberAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right: 20,
      child: SafeArea(
        child: IconButton(
          icon: const Icon(Icons.exit_to_app, color: Colors.white),
          iconSize: 30,
          tooltip: 'Exit to Menu',
          onPressed: () => _confirmExit(context),
        ),
      ),
    );
  }
}
