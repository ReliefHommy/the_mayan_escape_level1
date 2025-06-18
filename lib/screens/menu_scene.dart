import 'package:flutter/material.dart';

class MenuScene extends StatefulWidget {
  const MenuScene({super.key});

  @override
  State<MenuScene> createState() => _MenuSceneState();
}

class _MenuSceneState extends State<MenuScene> {
  void showHowToPlayDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.brown.shade900.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "How to Play",
          style: TextStyle(
            fontFamily: 'Gloock',
            fontSize: 24,
            color: Colors.amberAccent,
          ),
        ),
        content: SingleChildScrollView(
          child: Text(
            '''
🧩 Solve ancient puzzles by collecting items. 
🔥 Solve the first puzzle Rotating Stone Dial.
🗿 Tap on Animal glyphs, collect hidden objects, get a Passage Key.
🕯️ Use your intuition—and hints—to uncover secrets of the forgotten past.
🎯 Complete each challenge to unlock the next stage of your journey.
''',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: 'Georgia',
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close",
                style: TextStyle(color: Colors.amberAccent)),
          ),
        ],
      ),
    );
  }

  void showCreditsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.brown.shade900.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Credits",
          style: TextStyle(
            fontFamily: 'CinzelDecorative',
            fontSize: 24,
            color: Colors.amberAccent,
          ),
        ),
        content: SingleChildScrollView(
          child: Text(
            '''
🎮 Game Design & Development  
- Creative Gaze Studio  
- Solo Developer: Nok R. Tophitak

🎨 Art & Illustration  
- Custom assets by Nok R. Tophitak  
- MidJourney AI-inspired designs

🎼 Sound & Music  
- Ambient music: Eliche-Ancient Ruins



🛠️ Tools Used  
- Flutter & Dart  
- Audioplayers, Flame (for animations)
- GIMP, Wacom Tablet

Thank you for playing!
''',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: 'Georgia',
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close",
                style: TextStyle(color: Colors.amberAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background desktop
          Positioned.fill(
              child: Image.asset(
            'assets/images/menu_scene.jpg', // your decorative image
            fit: BoxFit.cover,
          )),
          Positioned(
              child: Center(
                  child: SizedBox(
            width: 700,
            child: Image.asset(
              'assets/images/menu_scene.jpg',
              //fit: BoxFit.cover,
            ),
          ))),

          // Logo / title/

          // Buttons
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
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
                    shadowColor: Colors.black87,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'CinzelDecorative',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/IntroScene'),
                  child: const Text("Begin Your Journey"),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
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
                    shadowColor: Colors.black87,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'CinzelDecorative',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => showHowToPlayDialog(context),
                  child: const Text("How to Play"),
                ),
                SizedBox(
                  height: 10,
                ),
                //
                ElevatedButton(
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
                    shadowColor: Colors.black87,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'CinzelDecorative',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => showCreditsDialog(context),
                  child: const Text("Credits"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Widget showHowToPlayDialog(BuildContext context) {}

  //Widget showCreditsDialog(BuildContext context) {}
}
