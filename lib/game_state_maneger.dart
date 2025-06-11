import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'dart:ui';

class GameStateManager extends ChangeNotifier {
  //------------------------
  // INVENTORY
  //--------------------------
  final Set<String> _inventory = {};
  List<String> get inventory => _inventory.toList();

  void collectItem(String itemName) {
    _inventory.add(itemName);
    notifyListeners();
  }

  bool hasItem(String itemName) => _inventory.contains(itemName);
  //------------------------
  // PUZZLE SOLVING STATUS
  //--------------------------

  final Set<String> _solvedPuzzles = {};
  // Puzzle Solving
  void markPuzzleAsSolved(String puzzleId) {
    _solvedPuzzles.add(puzzleId);
    notifyListeners();
  }

  bool isPuzzleSolved(String puzzleId) => _solvedPuzzles.contains(puzzleId);
  //------------------------
  // PUZZLE ROTATING STONE
  //--------------------------
  int _rotationIndex = 0;
  final List<String> _symbols = ['☀️', '🌙', '🔥', '🌿'];
  final String _correctSymbol = '🔥';

  int get rotationIndex => _rotationIndex;
  String get currentSymbol => _symbols[_rotationIndex];

  void rotateStoneDial(VoidCallback onSolved) {
    _rotationIndex = (_rotationIndex + 1) % _symbols.length;

    if (_symbols[_rotationIndex] == _correctSymbol) {
      onSolved(); // Call when puzzle solved
      markPuzzleAsSolved(
          'rotating_stone_dial'); // Optional: auto-mark as solved
    }

    notifyListeners();
  }

  void resetStoneDial() {
    _rotationIndex = 0;
    notifyListeners();
  }

  //------------------------
  // PUZZLE GLYPH ANIMAL
  //--------------------------

  final List<String> _correctGlyphOrder = ["🐆", "🦅", "🐍", "🐒"];
  final List<String> _userGlyphOrder = [];

  List<String> get correctGlyphOrder => _correctGlyphOrder;
  List<String> get userGlyphOrder => _userGlyphOrder;

  void tapGlyph(String glyph, VoidCallback onSolved) {
    if (!_userGlyphOrder.contains(glyph)) {
      _userGlyphOrder.add(glyph);

      // Check if sequence is complete
      if (_userGlyphOrder.length == _correctGlyphOrder.length) {
        if (_userGlyphOrder.join() == _correctGlyphOrder.join()) {
          onSolved(); // Success!
        } else {
          _userGlyphOrder.clear(); // Reset on fail
        }
      }
      notifyListeners(); // Rebuild UI
    }
  }

  void resetGlyphPuzzle() {
    _userGlyphOrder.clear();
    notifyListeners();
  }
  //void markPuzzleAsSolved(String s) {}
}
