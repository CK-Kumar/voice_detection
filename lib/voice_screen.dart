import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({Key? key}) : super(key: key);

  @override
  _VoiceScreenState createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      // ignore: avoid_print
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      // ignore: avoid_print
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      // ignore: avoid_print
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      // ignore: avoid_print
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      // ignore: avoid_print
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };
  late stt.SpeechToText _voice;
  bool _isListening = false;
  String _screenText = "Press to Speak";
  double accuracy = 1;
  @override
  void initState() {
    super.initState();
    _voice = stt.SpeechToText();
  }

  void _listen() async {
    setState(() => _isListening = true);

    if (!_isListening) {
      bool available = await _voice.initialize(
        // ignore: avoid_print
        onStatus: (val) => print('onStatus: $val'),
        // ignore: avoid_print
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _voice.listen(
          onResult: (val) => setState(() {
            _screenText = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              accuracy = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _voice.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Confidence: ${(accuracy * 100.0).toStringAsFixed(1)}%'),
        ),
        floatingActionButton: AvatarGlow(
          child: FloatingActionButton(
            onPressed: _listen,
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
          child: Container(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
            child: TextHighlight(
              text: _screenText,
              words: _highlights,
              textStyle: const TextStyle(
                fontSize: 32.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ));
  }
}
