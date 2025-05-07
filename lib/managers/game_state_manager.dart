import 'package:flutter/foundation.dart';

class GameStateManager extends ChangeNotifier {
  final Set<String> _inventory = {};
  final Set<String> _solvedPuzzles = {};
  final List<String> _correctGlyphOrder = [
    "🐍",
    "🦅",
    "🐆",
    "🐒"
  ]; // customize as needed

  // --- Inventory Logic ---
  void collectItem(String itemName) {
    _inventory.add(itemName);
    notifyListeners();
  }

  bool hasItem(String itemName) => _inventory.contains(itemName);

  List<String> get inventory => _inventory.toList();
  final List<String> _userGlyphOrder = [];
  List<String> get userGlyphOrder => _userGlyphOrder;
  List<String> get correctGlyphOrder => _correctGlyphOrder;

  // Puzzle Solving
  void markPuzzleAsSolved(String puzzleId) {
    _solvedPuzzles.add(puzzleId);
    notifyListeners();
  }

  bool isPuzzleSolved(String puzzleId) => _solvedPuzzles.contains(puzzleId);

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
}
