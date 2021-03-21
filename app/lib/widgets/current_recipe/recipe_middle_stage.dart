import 'package:app/models/recipe_stage.dart';
import 'package:app/providers/current_provider.dart';
import 'package:app/routes/navigation_provider.dart';
import 'package:app/services/text_to_speech_service.dart';
import 'package:app/widgets/current_recipe/stage_part.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../scrollable_body.dart';

class RecipeMiddleStageWidget extends StatefulWidget {
  final String words = '\nCall me when you\'ll be ready for next step.\n';
  final TextToSpeechService _textToSpeechService = TextToSpeechService();
  final RecipeStage recipeStage;
  bool isVoiceable;
  RecipeMiddleStageWidget({Key key, @required this.recipeStage})
      : super(key: key);

  Future<void> speakText() async {
    // if (isVoiceable) {
    final title = recipeStage.name;
    final parts = recipeStage.parts
        .where((element) => element.text != null)
        .map((e) => e.text);
    final buffer = StringBuffer(title);
    buffer.writeAll(parts, '\n');
    buffer.write(words);
    await _textToSpeechService.speakText(buffer.toString());
    //}
  }

  Future<void> stopText() async {
    // if (isVoiceable == null || isVoiceable) {
    await _textToSpeechService.stopSpeak();
    //}
  }

  @override
  _RecipeMiddleStageWidgetState createState() =>
      _RecipeMiddleStageWidgetState();
}

class _RecipeMiddleStageWidgetState extends State<RecipeMiddleStageWidget> {
  Future<void> _voicing;
  @override
  void initState() {
    widget.isVoiceable = context.read<NavigationProvider>().isVoiceNavigation;
    //  _voicing = widget.speakText();

    super.initState();
  }

  @override
  void dispose() async {
    widget.stopText();
    super.dispose();
  }

  Future<dynamic> doNothing() async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollableContent(
        body: [
          FutureBuilder(
            future: context.select<CurrentRecipeProvider, bool>(
                    (p) => p.isStageVoiceable)
                ? widget.speakText()
                : doNothing(),
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
              color: Color(0xFFF57600),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onPressed: () {
                final provider = context.read<CurrentRecipeProvider>();
                provider.toNextStage(false);
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 125,
                child: Text(
                  'Next',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
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
