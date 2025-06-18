import 'package:flutter/material.dart';

class WaterOfferingComicScene extends StatefulWidget {
  final VoidCallback onComplete;

  const WaterOfferingComicScene({required this.onComplete, super.key});

  @override
  State<WaterOfferingComicScene> createState() =>
      _WaterOfferingComicSceneState();
}

class _WaterOfferingComicSceneState extends State<WaterOfferingComicScene> {
  int currentPanel = 0;

  final List<_PanelData> panels = [
    _PanelData(
      imagePath: 'assets/images/basin_intro_bg.png',
      text:
          "In ancient Mayan temples, bowls like this were used to collect sacred water — believed to hold the spirits’ voice.",
    ),
    _PanelData(
      imagePath: 'assets/images/hiddenkeyintro_bg.png',
      text:
          "During a ceremony, the seeker would pour clear water into the bowl while whispering their intention.",
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
      backgroundColor: Colors.black.withValues(),
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
            Container(color: Colors.black.withValues()),

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
                      color: Colors.black.withValues(),
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
