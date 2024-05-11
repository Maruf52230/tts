import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VoiceApp(),
    );
  }
}

class VoiceApp extends StatefulWidget {
  @override
  _VoiceAppState createState() => _VoiceAppState();
}

class _VoiceAppState extends State<VoiceApp> {
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  String _text = 'Press the button and speak';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();
  }

  void _listen() async {
    if (!_speech.isListening) {
      if (await _speech.initialize()) {
        _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
              _speak();
            });
          },
        );
      }
    }
  }

  void _speak() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(getResponse(_text));
  }

  String getResponse(String input) {
    // Add logic to generate the response based on the input
    if (input.toLowerCase() == 'hello') {
      return 'Hi';
    } else {
      return 'I did not understand';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_text),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _listen,
              child: Text('Listen'),
            ),
          ],
        ),
      ),
    );
  }
}
