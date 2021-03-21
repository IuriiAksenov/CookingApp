import 'package:app/models/models.dart';
import 'package:app/providers/current_provider.dart';
import 'package:app/providers/favorite_provider.dart';
import 'package:app/routes/navigation_provider.dart';
import 'package:app/services/text_to_speech_service.dart';
import 'package:app/suplemental/helpers.dart';
import 'package:app/widgets/question_dialog.dart';
import 'package:app/widgets/recipe/recipe_header.dart';
import 'package:app/widgets/circled_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../scrollable_body.dart';

class RecipeWidget extends StatefulWidget {
  final TextToSpeechService _textToSpeechService = TextToSpeechService();
  final Recipe recipe;
  bool isVoiceable;
  RecipeWidget({Key key, @required this.recipe, @required this.isVoiceable})
      : super(key: key);

  @override
  _RecipeWidgetState createState() => _RecipeWidgetState();

  Future<void> speakText() async {
    if (isVoiceable) {
      final title = recipe.name;
      final buffer = StringBuffer(title + '\n');
      buffer.write(
          'You will need near the ${recipe.duration} minutes and it is suitable for ${recipe.servingsCount} person\n');

      await _textToSpeechService.speakText(buffer.toString());
      await _textToSpeechService
          .speakText('Do you know what ingredients you need?');
    }
  }

  Future<void> stopText() async {
    if (isVoiceable) {
      await _textToSpeechService.stopSpeak();
    }
  }
}

class _RecipeWidgetState extends State<RecipeWidget> {
  Future<void> _voicing;
  @override
  void initState() {
    widget.isVoiceable = context.read<NavigationProvider>().isVoiceNavigation;
    _voicing = widget.speakText();
    print('Here');
    final favoriteProvider = context.read<FavoriteRecipesProvider>();
    favoriteProvider.isInFavorite(widget.recipe.id).then((value) {
      setState(() {
        isFavorite = value ?? false;
      });
    });
    super.initState();
  }

  @override
  void dispose() async {
    widget.stopText();
    super.dispose();
  }

  bool isFavorite = false;
  Future _startCooking(BuildContext context, int recipeId) async {
    final CurrentRecipeProvider currentRecipesProvider =
        context.read<CurrentRecipeProvider>();
    if (currentRecipesProvider.hasRecipeInProgress) {
      var startNewCooking = await showDialog(
        context: context,
        builder: (_) => QuestionDialog(
          title: 'Start another recipe',
          question:
              'You already have a recipe in progress. Do you want to start another? Previous recipe will be deleted.',
        ),
      );
      if (startNewCooking == null || !startNewCooking) {
        return;
      }
    }

    await currentRecipesProvider.changeCurrentRecipe(recipeId);

    final NavigationProvider navigationProvider =
        context.read<NavigationProvider>();
    if (navigationProvider.currentTabIndex == Tabs.current) {
      navigationProvider.pushNames(
          names: ['/stage'], tab: Tabs.current, areVoicable: [false]);
    } else {
      navigationProvider.pushNames(
          names: ['/recipe', '/stage'],
          tab: Tabs.current,
          areVoicable: [false, false],
          arguments: [recipeId, null]);
    }
  }

  Future _continueCooking(BuildContext context, int recipeId) async {
    final NavigationProvider navigationProvider =
        context.read<NavigationProvider>();
    navigationProvider.pushName(
      tab: Tabs.current,
    );
  }

  Future<void> _toogle(BuildContext context, int id) async {
    final favoriteProvider = context.read<FavoriteRecipesProvider>();
    if (!isFavorite) {
      await favoriteProvider.add(id);
      setState(() {
        isFavorite = true;
      });
    } else {
      await favoriteProvider.delete(id);
      setState(() {
        isFavorite = false;
      });
    }
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
          RecipeHeader(imageUrl: widget.recipe.imageUrl),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              children: [
                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Text(
                        widget.recipe.name,
                        style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 0,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 26.0,
                        ),
                        onPressed: () async =>
                            await _toogle(context, widget.recipe.id),
                      ),
                    )
                  ],
                ),
                // Time and Servings count
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.schedule,
                      size: 24.0,
                      color: Colors.black,
                    ),
                    SizedBox(width: 2.0),
                    //Text(recipe.duration.inMinutes.toString() + ' min'),
                    Text(
                      Helpers.formatDurationString(widget.recipe.duration),
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(width: 8.0),
                    Icon(Icons.person_outline, size: 24.0),
                    Text(
                      widget.recipe.servingsCount.toString(),
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget.recipe.description,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                CircledListWidget(
                  title: 'Ingredients',
                  items: widget.recipe.ingredients,
                ),
                SizedBox(
                  height: 10.0,
                ),
                CircledListWidget(
                  title: 'Tablewares',
                  items: widget.recipe.tablewares,
                ),
              ],
            ),
          ),
        ],
        footer: context.select<CurrentRecipeProvider, int>(
                    (provider) => provider.currentRecipeId) ==
                widget.recipe.id
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: RaisedButton(
                  color: Color(0xFFF57600),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () async {
                    await _continueCooking(context, widget.recipe.id);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      'Continue cooking',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RaisedButton(
                  color: Color(0xFFF57600),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onPressed: () async {
                    await _startCooking(context, widget.recipe.id);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: Text(
                      'Start cooking',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
