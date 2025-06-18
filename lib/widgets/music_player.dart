import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPlayerButton extends StatefulWidget {
  const MusicPlayerButton({super.key});

  @override
  State<MusicPlayerButton> createState() => _MusicPlayerButtonState();
}

class _MusicPlayerButtonState extends State<MusicPlayerButton> {
  final AudioPlayer _bgmPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _bgmPlayer.setReleaseMode(ReleaseMode.loop);
  }

  void _toggleMusic() async {
    if (_isPlaying) {
      await _bgmPlayer.pause();
    } else {
      await _bgmPlayer.play(AssetSource('audio/mayan_intro.mp3'));
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _bgmPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isPlaying ? Icons.music_note : Icons.music_off,
        color: Colors.brown,
      ),
      tooltip: _isPlaying ? 'Pause Music' : 'Play Music',
      onPressed: _toggleMusic,
    );
  }
}
