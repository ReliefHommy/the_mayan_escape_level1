import 'package:flutter/material.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:mayan_level1/text_style.dart';

class RewardInventory extends StatefulWidget {
  const RewardInventory({super.key});

  @override
  State<RewardInventory> createState() => _RewardInventoryState();
}

class _RewardInventoryState extends State<RewardInventory>
    with TickerProviderStateMixin {
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
                            Colors.yellowAccent.withValues(),
                            Colors.orange.withValues(),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.6, 1.0],
                        ),
                      ),
                      child: Tooltip(
                        message: "Congratulation",
                        child: const Icon(Icons.auto_awesome,
                            size: 40, color: Colors.white),
                      )),
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
                  color: Colors.brown.withValues(),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.redAccent, width: 2),
                ),
                child: const Text(
                  "You have unlocked the Entrance!",
                  style: rewardHintTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
