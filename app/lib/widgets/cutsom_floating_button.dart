import 'package:app/providers/voice_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CustomFloatingButtons extends StatefulWidget {
  CustomFloatingButtons({Key key}) : super(key: key);

  @override
  _CustomFloatingButtonsState createState() => _CustomFloatingButtonsState();
}

class _CustomFloatingButtonsState extends State<CustomFloatingButtons> {
  @override
  Widget build(BuildContext context) {
    final isListening =
        context.select<VoiceProvider, bool>((provider) => provider.isListening);
    final stopListening =
        context.select<VoiceProvider, Future<void> Function()>(
            (provider) => provider.stopListening);
    final startListening =
        context.select<VoiceProvider, Future<void> Function()>(
            (provider) => provider.startListening);
    return Stack(
      children: [
        Positioned(
          right: 5,
          bottom: 50,
          child: FloatingActionButton(
            child: Icon(
              Icons.mic,
              size: 40,
            ),
            backgroundColor: isListening ? Colors.red : Color(0xfff47600),
            onPressed: () async {
              if (isListening) {
                await stopListening();
              } else {
                await startListening();
                Fluttertoast.showToast(
                    msg: "Please speak...",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
          ),
        ),
      ],
    );
  }
}
