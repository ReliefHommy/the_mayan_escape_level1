import 'package:flutter/material.dart';

class CollectItemIntro extends StatefulWidget {
  final VoidCallback onComplete;

  const CollectItemIntro({
    required this.onComplete,
    super.key,
    required List inventory,
    required Null Function(dynamic item) onItemCollected,
    required Null Function() hasAllRequiredItemsExternal,
  });

  @override
  State<CollectItemIntro> createState() => _CollectItemIntroState();
}

class _CollectItemIntroState extends State<CollectItemIntro> {
  int currentPanel = 0;

  final List<_PanelData> panels = [
    _PanelData(
      imagePath: 'assets/images/dagger_bg.png',
      text:
          "Half-buried in moss and shadow,a ceremonial dagger rests on a stone pedestal.This is no weapon. It is a key",
    ),
    _PanelData(
      imagePath: 'assets/images/serpent_bg.png',
      text:
          "Coiled in silence, the serpent's stone eyes glint with forgotten knowledge. This idol was not carved for worship—but for awakening",
    ),
  ];

  void _nextPanel() {
    if (currentPanel < panels.length - 1) {
      setState(() => currentPanel++);
    } else {
      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final panel = panels[currentPanel];

    return Scaffold(
      //color: Colors.white.withOpacity(0.5),
      // backgroundColor: Colors.white.withOpacity(0.5),
      body: GestureDetector(
        onTap: _nextPanel,
        child: Stack(
          children: [
            // Panel image
            Positioned.fill(
              child: Image.asset(
                panel.imagePath,
                fit: BoxFit.cover,
              ),
            ),

            // Dark overlay
            Container(color: Colors.black.withOpacity(0.1)),

            // Text box
            Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child: Tooltip(
                  message: 'Tap On Texts',
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      panel.text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),

            // Panel counter (optional)
            Positioned(
              top: 40,
              right: 20,
              child: Text(
                "Panel ${currentPanel + 1} / ${panels.length}",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PanelData {
  final String imagePath;
  final String text;

  const _PanelData({required this.imagePath, required this.text});
}
