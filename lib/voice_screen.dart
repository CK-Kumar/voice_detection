import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({Key? key}) : super(key: key);

  @override
  _VoiceScreenState createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  late stt.SpeechToText _voice;
  bool _isListening = false;
  String _screenText = "Press to Speak";
  double accuracy = 1;
  void initState() {
    super.initState();
    _voice = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accuracy : ${accuracy}'),
      ),
      floatingActionButton: AvatarGlow(
        child: FloatingActionButton(
          onPressed: null,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
        endRadius: 75,
        animate: _isListening,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        glowColor: Colors.green,
        repeat: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(),
      ),
    );
  }
}
