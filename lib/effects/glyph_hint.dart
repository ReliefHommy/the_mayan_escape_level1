import 'package:flutter/material.dart';
import 'package:mayan_level1/text_style.dart';

//import 'package:audioplayers/audioplayers.dart';

class GlyphHint extends StatefulWidget {
  const GlyphHint({super.key});

  @override
  State<GlyphHint> createState() => _GlyphHintState();
}

class _GlyphHintState extends State<GlyphHint> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _showHint = false;

  //final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    //_audioPlayer.dispose();
    super.dispose();
  }

//- assets/audio/Slide On Concrete Series.mp3
  void _revealHint() async {
    //await _audioPlayer
    //.play(AssetSource('audio/810754__mokasza__level-up-02.mp3'));

    setState(() {
      _showHint = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Pulsing Hint Marker
        Center(
          child: GestureDetector(
            onTap: _revealHint,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                double scale = 1 + 0.2 * _pulseController.value;
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.yellowAccent.withOpacity(0.8),
                          Colors.orange.withOpacity(0.4),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                    child: const Icon(Icons.extension_outlined,
                        size: 40, color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ),

        // Hint Reveal Panel
        if (_showHint)
          Center(
            child: AnimatedOpacity(
              opacity: _showHint ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Text(
                  "Hint: 1-Dog,2-Bird,3-Snake,4-Monkey",
                  style: hintTextStyle,
                ),
              ),
            ),
          )
      ],
    );
  }
}

//
