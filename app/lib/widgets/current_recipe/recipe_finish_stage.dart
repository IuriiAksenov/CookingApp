import 'package:app/models/recipe_stage.dart';
import 'package:app/routes/navigation_provider.dart';
import 'package:app/providers/current_provider.dart';
import 'package:app/services/text_to_speech_service.dart';
import 'package:app/widgets/current_recipe/stage_part.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../scrollable_body.dart';

class RecipeFinishStageWidget extends StatefulWidget {
  final String words = '\nThat\'s all. Call me when you\'ll finish cooking.\n';
  final TextToSpeechService _textToSpeechService = TextToSpeechService();
  final RecipeStage recipeStage;

  RecipeFinishStageWidget({Key key, @required this.recipeStage})
      : super(key: key);

  @override
  _RecipeFinishStageWidgetState createState() =>
      _RecipeFinishStageWidgetState();
}

class _RecipeFinishStageWidgetState extends State<RecipeFinishStageWidget> {
  bool isVoiceable;
  Future<void> _voicing;
  Future<void> speakText() async {
    if (isVoiceable) {
      final title = widget.recipeStage.name;
      final parts = widget.recipeStage.parts
          .where((element) => element.text != null)
          .map((e) => e.text);
      final buffer = StringBuffer(title);
      buffer.writeAll(parts, '\n');
      buffer.write(widget.words);
      await widget._textToSpeechService.speakText(buffer.toString());
    }
  }

  Future<void> stopText() async {
    if (isVoiceable == null || isVoiceable) {
      await widget._textToSpeechService.stopSpeak();
    }
  }

  @override
  void initState() {
    isVoiceable = context.read<NavigationProvider>().isVoiceNavigation;
    _voicing = speakText();
    super.initState();
  }

  @override
  void dispose() async {
    stopText();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollableContent(
        body: [
          FutureBuilder(
            future: _voicing,
            builder: (_, __) => SizedBox.shrink(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.recipeStage.name,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                ...widget.recipeStage.parts
                    .map((part) => StagePart(stagePart: part))
                    .toList(),
              ],
            ),
          )
        ],
        footer: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              color: Color(0xFFF57600),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onPressed: () {
                final provider = context.read<CurrentRecipeProvider>();
                provider.toPreviousStage(false);
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 125,
                child: Text(
                  'Previous',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: Color(0xFFF57600), width: 1.0),
              ),
              onPressed: () {
                final provider = context.read<CurrentRecipeProvider>();
                final navigation = context.read<NavigationProvider>();
                navigation.popAll();
                provider.finish();
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 125,
                child: Text(
                  'Finish',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF57600),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
